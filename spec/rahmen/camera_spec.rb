require 'spec_helper'
require 'rahmen'
require 'rahmen/camera'

module Rahmen
  describe :Camera do
    it do
      Rahmen::Camera.new.capture
    end
  end
end
