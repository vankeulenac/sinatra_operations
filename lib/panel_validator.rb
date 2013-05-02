class PanelValidator
  def self.check_attributes attributes
    check_empty attributes
    check_title attributes[:title]
    check_subtitle attributes[:subtitle]
    check_order attributes[:order]
    check_content attributes[:content]
  end

  def self.check_empty attributes
    if  attributes.empty? 
      raise ArgumentError, "Panel is empty"
    end
  end

  def self.check_title title
    if title == "" || title == nil || title.class != String
      raise ArgumentError, "Panel does not have a valid title."
    end
  end

  def self.check_subtitle subtitle
    if subtitle.class != String
      raise ArgumentError, "Panel does not have a valid subtitle."
    end
  end

  def self.check_content(content)
    if content.class != String
      raise ArgumentError, "Panel does not have valid content."
    end
  end

  def self.check_order(order)
    if order.class != Fixnum
      raise ArgumentError, "Panel does not have a valid order."
    end
  end
end
