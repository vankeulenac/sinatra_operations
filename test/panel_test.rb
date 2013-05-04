require 'test_helper'
require 'pry'

describe "Panel" do
  let(:p1) do 
    {
      title: "Title",
      subtitle: "Great Slide",
      content: "This is an amazing slide",
      order: 1
    }
  end
  let(:panel) { Panel.from_hash(p1) }
	let(:panel_list) { 3.times { Panel.from_hash(p1) }}

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

  context "#from_hash" do
    it "should create a new panel from hash" do
      panel.title.must_equal "Title"
      panel.subtitle.must_equal "Great Slide"
    end
    
    it "should add_panel to panels array" do
			size = panel_list
			Panel.from_hash(p1) 
      Panel.all.size.must_equal size + 1
    end

    context "validations" do
      it "should raise an exception with an empty hash" do
        ->{ Panel.from_hash({}) }.must_raise(ArgumentError)
      end

      it "should raise an exception without valid title" do
        ->{ Panel.from_hash({subtitle: "Great Slide"}) }.must_raise(ArgumentError)
        ->{ Panel.from_hash({title: ""}) }.must_raise(ArgumentError)
        ->{ Panel.from_hash({title: 1}) }.must_raise(ArgumentError)
      end

      it "should raise an exception without a valid subtitle" do
        ->{ Panel.from_hash({title: "h1", subtitle: 1}) }.must_raise ArgumentError
      end

      it "should raise an exception without valid content" do
        p1[:content] = 123455
        ->{ Panel.from_hash(p1) }.must_raise ArgumentError
      end

      it "should raise an exception without a valid order" do
        p1[:order] = "bla"
        ->{ Panel.from_hash(p1) }.must_raise ArgumentError
      end
    end
  end

  context "#attributes" do
    it "must have the same attributes as hash" do
      panel.attributes.must_equal p1
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
