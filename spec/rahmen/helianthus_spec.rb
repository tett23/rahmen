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
        Helianthus.upload_image Camera.new.capture
      end
    end
  end
end
