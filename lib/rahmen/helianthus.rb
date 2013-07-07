module Rahmen
  module Helianthus
    API_MAPPING = {
      init: {
        method: :post,
        url: '/api/init'
      },
      image_upload: {
        method: :put,
        url: '/api/images/upload'
      }
    }
    SERVER = 'http://192.168.1.101:3000'

    extend self

    def init
      post :init
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

    def post(api, data={})
      res = connection.post do |req|
        req.url API_MAPPING[api][:url]
        req.headers['Content-Type'] = 'application/json'
        req.headers['X-Requested-With'] = 'XMLHttpRequest'
        req.body = data.to_s
      end if api_exist?(api, :post)
      check_response(res)

      JSON.parse(res.env[:body]).symbolize_keys
    end

    def put(api, data={})
      res = connection.post do |req|
        req.url API_MAPPING[api][:url]
        req.headers['Content-Type'] = 'application/json'
        req.headers['X-Requested-With'] = 'XMLHttpRequest'
        req.body = data.to_s
      end if api_exist?(api, :put)
      check_response(res)

      JSON.parse(res.env[:body]).symbolize_keys
    end

    def connection
      Faraday::Connection.new(url: SERVER) do |builder|
        builder.request :url_encoded
        builder.adapter :net_http
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
