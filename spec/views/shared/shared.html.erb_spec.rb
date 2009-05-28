require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper' )

describe "shared/_head.html.erb" do
  before(:each) do
    render "shared/_head.html.erb"
  end

  it "should display the title text 'Inventario de hardware'" do
    assert_select 'title', 'Inventario de hardware'
  end

  it "should has a three metatags, three script" do
    assert_select "head" do |elements|
      elements.each do |element|
        assert_select element, "meta", 3
        assert_select element, "script", 3
        assert_select element, "link", 2
      end
    end
  end
 end
