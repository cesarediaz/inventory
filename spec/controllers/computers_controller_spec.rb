require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')


def mock_computers
  @computer = mock_model(Computer, :name => "pc_uno", :mac => "23:43:12:76:23:25",
                         :ip => "192.160.104.91")
  @computers = [@computer]
  @computers.stub!(:recent).and_return([@computer])
  Computer.stub!(:published).and_return(@computers)
  @computers.stub!(:find).and_return(@computers)
end

describe ComputersController do

  describe "handling GET /computers" do

    before(:each) do
      @computer = mock_model(Computer, :title => "hello")
      Computer.stub!(:find).and_return([@computer])
    end

    def do_get
      get :index
    end

    it "should be successful" do
      do_get
      response.should be_success
    end

    it "should render index template" do
      do_get
      response.should render_template('index')
    end

    it "should find all computers" do
      Computer.should_receive(:paginate).with({:page => nil,
        :order => 'created_at DESC',
        :conditions => nil}).and_return([@computer])
      do_get
    end

    it "should assign the found computers for the view" do
      do_get
      assigns[:computers].should == [@computer]
    end

  end


  describe "handling DELETE /computers/1" do

    before(:each) do
      @computer = mock_model(Computer, :destroy => true)
      Computer.stub!(:find).and_return(@computer)
      end

    def do_delete
      delete :destroy, :id => "1"
    end

    it "should find the computer requested" do
      Computer.should_receive(:find).with("1").once.and_return(@computer)
      do_delete
    end

    it "should call destroy on the found computer" do
      @computer.should_receive(:destroy)
      do_delete
    end

    it "should redirect to home" do
      do_delete
      response.should redirect_to(computers_url)
    end
  end



end
