require_relative './panel_validator'
require 'json'
require 'sdbm'
require 'pstore'

Panel = Struct.new(:title, :subtitle, :content, :order) do

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

    def validator
      PanelValidator
    end

    def from_hash attributes
      validator.check_attributes attributes
      instance = self.new
      attributes.each do |key, value|
        instance[key] = value
      end
      self.add_panel instance
      instance
    end

    def to_json
      all.map(&:to_json)
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
end
