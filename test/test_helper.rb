require 'bundler/setup'
require 'panels'
require 'minitest/autorun'
require 'minitest-colorize'

Dir[File.join("test", "support", "**", "*.rb")].each do |file|
  require File.expand_path(file)
end

class MiniTest::Spec
  class << self
    alias :context :describe
  end

  before do
     Panel.clear
  end

end
