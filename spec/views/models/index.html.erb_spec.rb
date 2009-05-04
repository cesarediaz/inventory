require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper' )

describe "/models/index" do
  it "should use the list partial" do
    template.should_receive(:render).with(:partial => 'list')
    render "/models/index"
  end
end


describe "/models/index.html.erb" do

  before do
    @models = Model.find(:all)
    assigns[:models] = @models
    render '/models/index.html.erb'
  end

  it "should display link to new model" do
    response.should have_tag("a[href='/models/new']") do
    end
  end

  it "should display table" do
    response.should have_tag("table") do
      assert_select "table" do |elements|
        elements.each do |element|
          assert_select element, "th", 4
        end
      end
    end
  end


end
