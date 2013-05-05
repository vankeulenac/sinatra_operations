require 'test_helper'

describe PanelDB do
  context "#self.all" do
    it "should return all slides" do
      size = panel_list
      Panel.all.size.must_equal size
    end
  end

  context "#self.clear" do
    it "should return no slides" do
      size = panel_list
      Panel.clear
      Panel.all.size.must_equal 0
    end
  end

  context "#self.from_hash" do   
    it "should add_panel to panels array" do
			size = panel_list
			Panel.from_hash(p1) 
      Panel.all.size.must_equal size + 1
    end
  end

 
end
