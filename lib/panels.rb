require_relative './panel_validator'
require_relative './panel_db'
require 'json'
require 'forwardable'

Panel = Struct.new(:title, :subtitle, :content, :order) do
  extend Forwardable
  def_delegator PanelValidator, :check_attributes

  def initialize attributes
    check_attributes attributes
    attributes.each do |key, value|
      self[key] = value
    end
  end

	def to_json
		self.to_h.to_json
	end

  class << self
    extend Forwardable
    def_delegators PanelDB, :add_panel, :all, :clear

    def from_hash attributes
      instance = self.new attributes
      self.add_panel instance
      instance
    end

    def to_json
      self.all.map(&:to_json)
    end
  end
end
