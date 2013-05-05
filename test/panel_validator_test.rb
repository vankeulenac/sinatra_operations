require 'test_helper'

describe PanelValidator do

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
