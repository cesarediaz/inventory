require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper' )

describe "/models/new" do
  it "should use the form partial" do
    template.should_receive(:render).with(:partial => 'form')
    render "/models/new"
  end
end

describe "/models/_form.html.erb" do
  before do
    @model = Model.new
    assigns[:model] = @model
    render '/models/_form.html.erb'
  end

  it "should display form fiels" do

    response.should have_tag("form[action=/models]") do
      with_tag("input[id=model_description]")
      with_tag("select[id=model_mark_id]")
      with_tag("input[id=model_submit]")
    end
  end
end

