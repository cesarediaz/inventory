require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper' )

describe "/models/index" do
  it "should use the list partial" do
    template.should_receive(:render).with(:partial => 'list')
    render "/models/index"
  end
end
