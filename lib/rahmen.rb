require 'rubygems'
require 'bundler'
Bundler.require

require 'opencv'
require 'digest/sha1'
require 'fileutils'
require 'active_support/core_ext'

module Rahmen
  extend self

  def self.init
    Helianthus.init
  end
end
