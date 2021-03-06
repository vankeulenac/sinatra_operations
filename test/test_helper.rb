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

  let(:p1) do 
    {
      title: "Title",
      subtitle: "Great Slide",
      content: "This is an amazing slide",
      order: 1
    }
  end
  let(:panel) { Panel.new(p1) }
	let(:panel_list) { 3.times { Panel.from_hash(p1) }}

end
