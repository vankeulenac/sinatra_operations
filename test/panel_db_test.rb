require 'test_helper'

describe PanelDB do

  before do
    @size = Panel.all.size
  end

  context "#self.all" do
    it "should return all slides" do
      Panel.all.size.must_equal @size
    end
  end

  context "#self.clear" do
    it "should return no slides" do
      Panel.clear
      Panel.all.size.must_equal 0
    end
  end

  context "#self.add_panel" do
    it "should add a panel to collection" do
      Panel.add_panel(p1)
      Panel.all.size.must_equal @size + 1
    end
  end
end
