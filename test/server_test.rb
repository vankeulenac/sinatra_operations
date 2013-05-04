require 'test_helper'

describe PanelApp do
  it "should be ok" do
    get '/'
    last_response.must_be :ok?
  end
end
