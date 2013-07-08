require 'spec_helper'
require 'rahmen'
require 'rahmen/helianthus'
require 'rahmen/camera'

module Rahmen
  describe :Helianthus do
    describe :apis do
      it 'init' do
        Helianthus.init
      end
      it 'upload image' do
        Helianthus.upload_image Camera.new.capture
      end
    end
  end
end
