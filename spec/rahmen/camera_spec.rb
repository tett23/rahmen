require 'spec_helper'
require 'rahmen'
require 'rahmen/camera'

module Rahmen
  describe :Camera do
    it 'capture' do
      camera = Rahmen::Camera.new
      out_path = camera.__send__(:default_out_path)
      out = camera.capture(out_path)

      out.should == out_path
    end
  end
end
