require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper' )

describe "computers/show.html.erb" do
  before(:each) do
    @computer = mock_model(Computer,
                           :id => 1,
                           :name => "pc_1",
                           :ip => '132.54.23.60',
                           :mac => '13:23:43:15:53:30',
                           :inventory_register => '23429342',
                           :available => true)
    Computer.stub!(:find).and_return(@computer)
    assigns[:computer] = @computer
  end

  it "should display the text of the place" do
    render "computers/show.html.erb"
    assert_select 'p', 'Place'
  end
end
