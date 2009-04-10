require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper' )

describe "shared/_head.html.erb" do
  before(:each) do
    render "shared/_head.html.erb"
  end

  it "should display the title text 'Inventory of hardware'" do
    assert_select 'title', 'Inventory of hardware'
  end

  it "should has a meta tag keywords empty" do
    assert_select "head" do |elements|
      elements.each do |element|
        assert_select element, "meta", 3
      end
    end
  end
 end


