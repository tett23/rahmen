require 'spec_helper'
require 'rahmen'
require 'rahmen/camera'
require 'rahmen/image'

module Rahmen
  describe :Image do
    it 'feature_point' do
      file_path = Rahmen::Camera.new.capture

      image = Rahmen::Image.new(file_path)
      image.feature_point
    end
  end
end
