require 'spec_helper'
require 'rahmen'
require 'rahmen/helianthus'

module Rahmen
  describe :Helianthus do
    describe :apis do
      it do
        Helianthus::API_MAPPING.each do |api, param|
          Helianthus.__send__(param[:method], api)[:result].should be_true
        end
      end
    end
  end
end
