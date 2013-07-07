require 'spec_helper'
require 'rahmen'
require 'rahmen/helianthus'
require 'rahmen/camera'

module Rahmen
  describe :Helianthus do
    describe :apis do
      it 'is exists apis' do
        Helianthus::API_MAPPING.each do |api, param|
          Helianthus.__send__(param[:method], api)[:result].should be_true
        end
      end
      it 'upload image' do
        data = {}
        image_path = Rahmen::Camera.new.capture
        mime_type = MIME::Types.type_for(image_path).first.to_s

        data[:profile_pic] = Faraday::UploadIO.new(image_path, mime_type)

        Helianthus.post :upload_image, data
      end
    end
  end
end
