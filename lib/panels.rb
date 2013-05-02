require_relative './panel_validator'

Panel = Struct.new(:title, :subtitle, :content, :order) do

  PANELS = []

  def self.all
    PANELS
  end

  def self.clear
    PANELS.clear
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
    PANELS << instance
    instance
  end

  def attributes
    result = {}
    members.each do |name|
      result[name] = self[name]
    end
    result
  end
end
