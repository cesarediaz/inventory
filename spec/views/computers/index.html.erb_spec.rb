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

    @computer_one = mock_model(Computer, :name => "pc_1", :ip => '132.54.23.60', :mac => '13:23:43:15:53:30',
                           :available => true)
    @computer_two = mock_model(Computer, :name => "pc_2", :ip => '132.54.23.61', :mac => '13:23:43:15:53:31',
                           :available => false)
    @computers = [@computer_one, @computer_two]
    assigns[:computers] = @computers
  end

  it "should display the text of the place" do
    render "computers/show.html.erb"
    assert_select 'p', 'Lugar'
  end

 end

 describe "computers/_search.html.erb" do
  it "should display the text link to Show/Hide the search" do
    render "computers/_search.html.erb"
    assert_select 'a', 'Mostrar/Ocultar'
    assert_select 'td', 'Nombre'
  end

end
