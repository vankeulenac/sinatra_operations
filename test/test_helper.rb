require 'bundler/setup'
require 'panels'
require_relative '../app'
require 'minitest/autorun'
require 'minitest-colorize'
require 'rack/test'

ENV['RACK_ENV'] = 'test'

Dir[File.join("test", "support", "**", "*.rb")].each do |file|
  require File.expand_path(file)
end

include Rack::Test::Methods

def app
  PanelApp
end

class MiniTest::Spec
  class << self
    alias :context :describe
  end

  before do
    Panel.clear
  end

end
