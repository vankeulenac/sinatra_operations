require 'test_helper'

describe Panel do

  context "#new" do
    it "should create a new panel from hash" do
      panel.title.must_equal "Title"
      panel.subtitle.must_equal "Great Slide"
    end
  end

  context "#self.from_hash" do   
    it "should add_panel to panels array" do
			size = panel_list
			Panel.from_hash(p1) 
      Panel.all.size.must_equal size + 1
    end
  end

  context "#to_json" do
    it "must output the original hash as json" do
      panel.to_json.must_equal p1.to_json
    end	
  end

  context "#self.to_json" do
    it "must output all the class instances as json" do
      panel_list
      Panel.to_json.must_equal Panel.all.map(&:to_json)
    end
  end
end
