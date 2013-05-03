require_relative './panel_validator'
require 'json'
require 'sdbm'

Panel = Struct.new(:title, :subtitle, :content, :order) do

  class << self

	  def panels
      @db ||= SDBM.open('panels.dbm')['[panels']
	  end

	  def add_panel(arg)
	    @db += "#{arg}\n\n"
	  end

    def all
      if self.panels == ""
        []
      else
        panels = self.panels.split("\n\n")
        panels.map { |panel| JSON.parse(panel) }
      end
    end

    def clear
      @db = ""
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
      self.add_panel instance.to_json
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
