require 'faraday/request/multipart'
require 'net/http'

class Hash
  def bytesize
    self.to_json.size
  end
end

module Rahmen
  module Helianthus
    API_MAPPING = {
      init: {
        method: :post,
        url: '/api/init'
      },
      image_upload: {
        method: :post,
        url: '/api/images/upload'
      }
    }
    SERVER = 'http://192.168.1.101:3000'

    extend self

    def init
      post :init
    end

    def upload_image(image_path)
      mime_type = MIME::Types.type_for(image_path).first.to_s
      data = {}
      data[:image] = Faraday::UploadIO.new(image_path, mime_type).to_json

      Net::HTTP.post_form(URI(SERVER+API_MAPPING[:image_upload][:url]), data)

      #connection.post '/api/images/upload', data
      #post :image_upload, data, multipart: true
    end

    private
    def get(api, data={})
      connection.get do |req|
        req.url API_MAPPING[api][:url]
        req.headers['Content-Type'] = 'application/json'
        req.headers['X-Requested-With'] = 'XMLHttpRequest'
      end if api_exist?(api, :get)
      check_response(res)

      JSON.parse(res.env[:body]).symbolize_keys
    end

    def post(api, data={}, options={})
      res = connection(options).post do |req|
        req.url API_MAPPING[api][:url]
        req.headers['Content-Type'] = 'application/json'
        req.headers['X-Requested-With'] = 'XMLHttpRequest'
        req.body = data

        options[:headers].each do |header, val|
          req.headers[header.to_s] = val
        end if options.key?(:headers)
      end if api_exist?(api, :post)
      check_response(res)

      JSON.parse(res.env[:body]).symbolize_keys
    end

    def put(api, data={})
      res = connection.put API_MAPPING[api][:url], data.to_json do |req|
        req.headers['Content-Type'] = 'application/json'
        req.headers['X-Requested-With'] = 'XMLHttpRequest'

        options[:headers].each do |header, val|
          req.headers[header.to_s] = val
        end if options.key?(:headers)
      end if api_exist?(api, :put)
      check_response(res)

      JSON.parse(res.env[:body]).symbolize_keys
    end

    def connection(options={})
      Faraday::Connection.new(url: SERVER) do |builder|
        builder.adapter Faraday.default_adapter
        builder.request :url_encoded
        #builder.response :json, :content_type => "application/json"
          builder.request :multipart

        if options.key?(:multipart)
          builder.request :multipart
        else
          builder.request :url_encoded
        end
      end
    end

    def api_exist?(key, method)
      API_MAPPING.key?(key) && API_MAPPING[key][:method] == method.to_sym
    end

    def check_response(res)
      raise "status: #{res.env[:status].to_s}" unless res.env[:status] == 200
    end
  end
end
