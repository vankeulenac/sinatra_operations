require_relative './panel_validator'
require 'json'
require 'sdbm'

Panel = Struct.new(:title, :subtitle, :content, :order) do

	DB = SDBM.open('panels.dbm') 

	def self.panels
		DB['panels'] ||= ""
	end

	def self.add_panel(arg)
		if panels
			DB['panels'] += "#{arg}\n"
		end
	end

  def self.all
		if self.panels == ""
			[]
		else
			panels = self.panels.split("\n")
			panels.map { |panel| JSON.parse(panel) }
		end
  end

  def self.clear
		DB['panels'] = ""
  end

  def self.validator
    PanelValidator
  end

  def self.from_hash attributes
    validator.check_attributes attributes
    instance = self.new
    attributes.each do |key, value|
      instance[key] = value
    end
    self.add_panel instance.to_json
    instance
  end

	def self.to_json
		all.map(&:to_json)
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
