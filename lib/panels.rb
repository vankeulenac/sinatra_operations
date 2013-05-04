require_relative './panel_validator'
require 'json'
require 'sdbm'
require 'pstore'
require 'forwardable'

class PanelDB
  class << self
   def store
      store ||= PStore.new("panels.store") do |db|
        db["panels"] = [] unless db["panels"]
      end
    end
    
   def add_panel(arg)
      store.transaction do |db|
        db["panels"] << arg
      end
	  end

    def all
      store.transaction do |db|
        db["panels"]
      end
    end

    def clear
      store.transaction do |db|
        db["panels"] = []
      end
    end
  end
end

Panel = Struct.new(:title, :subtitle, :content, :order) do
  extend Forwardable
  def_delegator PanelValidator, :check_attributes

  def initialize attributes
    check_attributes attributes
    attributes.each do |key, value|
      self[key] = value
    end
  end

  def attributes
    result = {}
    members.each do |name|
      result[name] = self[name]
    end
    result
  end
	
	def to_json
		self.attributes.to_json
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
      all.map(&:to_json)
    end
  end
end
