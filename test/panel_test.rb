require 'test_helper'

describe Panel do

  context "#new" do
    it "should create a new panel from hash" do
      panel.title.must_equal "Title"
      panel.subtitle.must_equal "Great Slide"
    end
  end

  context "#to_json" do
    it "must output the original hash as json" do
      panel.to_json.must_equal p1.to_json
    end	

    it "must output all the class instances as json" do
      panel_list
      Panel.to_json.must_equal Panel.all.map(&:to_json)
    end
  end
end
