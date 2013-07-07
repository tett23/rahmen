require 'spec_helper'
require 'rahmen'
require 'rahmen/helianthus'

module Rahmen
  describe :Rahmen do
    describe :init do
      it do
        Rahmen.init[:result].should be_true
      end
    end
  end
end
