require File.dirname(__FILE__) + '/../spec_helper'

# Be sure to include AuthenticatedTestHelper in spec/spec_helper.rb instead
# Then, you can remove it from this and the units test.
include AuthenticatedTestHelper


describe ComputersController do

  def login
    @user = mock_model(User)
    @login_params = { :login => 'admin', :password => 'testing' }
    post :create, @login_params
    User.stub!(:authenticate).with(@login_params[:login], @login_params[:password]).and_return(@user)
    controller.stub!(:logged_in?).and_return(true)
    controller.stub!(:set_user_language).and_return('en')
  end

  def mock_computers
    @computer_one = mock_model(Computer, :name => "pc_1", :ip => '132.54.23.60', :mac => '13:23:43:15:53:30',
                           :available => true)
    @computer_two = mock_model(Computer, :name => "pc_2", :ip => '132.54.23.61', :mac => '13:23:43:15:53:31',
                           :available => false)
    @computers = [@computer_one, @computer_two]
    @computers_available = [@computer_one]
    @computers_unavailable = [@computer_two]
    Computer.stub!(:available).and_return(@computers_available)
    Computer.stub!(:unavailable).and_return(@computers_unavailable)
    @computers.stub!(:find).and_return(@computers)
  end

  def do_get_index
    get :index
  end

  def do_get_available
    get :available
  end

  def do_get_unavailable
    get :unavailable
  end

  describe "get index" do
    before(:each) do
      @computer = [mock_model(Computer)]
      Computer.stub!(:paginate).and_return(@computer)
    end

    it "should be successful" do
      login
      do_get_index
      response.should be_success
    end

    it "should have n records" do
      login
      do_get_index
      @computer.should have(1).items
    end

    it "should assings computers" do
      login
      assigns[:computers].should == @computers
    end

    it "should be unsuccessful without logged in and get sessions new" do
      response.should_not be_success
      get 'sessions/new'
    end

    it "should paginate computers" do
      login
      do_get_index
      Computer.should_receive(:paginate).with(:page => nil,
                                              :per_page => 10,
                                              :order => 'created_at DESC')
    end

  end

  describe "get computers/available" do
    before(:each) do
      login
      mock_computers
    end

    it "should be successful" do
      do_get_available
      response.should be_success
    end

    it "should have n records" do
      login
      do_get_available
      @computers_available.should have(1).items
    end

    it 'should find all computers availables' do
      do_get_available
      Computer.should_receive(:available).and_return(@computers)
    end

    it 'should find all computers availables and assigns an @computers variable' do
      do_get_available
      assigns[:computers].should == @computers_available
    end

  end

  describe "get computers/unavailable" do

    before(:each) do
      login
      mock_computers
    end

    it "should be successful" do
      do_get_unavailable
      response.should be_success
    end

    it 'should find all computers unavailables and assigns an @computers variable' do
      do_get_unavailable
      assigns[:computers].should == @computers_unavailable
    end

    it "should have n records" do
      login
      @computers_unavailable.should have(1).items
    end

    it 'should find all computers unavailables' do
      do_get_unavailable
      Computer.should_receive(:unavailable).and_return(@computers)
    end

    describe "handling GET /computers/1/edit" do

      before(:each) do
        login
        mock_computers
        Computer.stub!(:find).and_return(@computer)
      end

      def do_get
        get :edit, :id => "1"
      end

      it "should be successful" do
        do_get
        response.should be_success
      end

      it "should render edit template" do
        do_get
        response.should render_template('edit')
      end

      it "should assign the found Computer for the view" do
        do_get
        assigns[:computer].should equal(@computer)
      end

    end

  end


  describe "route generation" do


    it "should route computers's 'index' action correctly" do
      route_for(:controller => 'computers', :action => 'index').should == "/computers"
    end

    it "should route computers's 'new' action correctly" do
      route_for(:controller => 'computers', :action => 'new').should == "/computers/new"
    end

    it "should route {:controller => 'computers', :action => 'create'} correctly" do
      route_for(:controller => 'computers', :action => 'create').should == "/computers"
    end

    it "should route computers's 'show' action correctly" do
      route_for(:controller => 'computers', :action => 'show', :id => '1').should == "/computers/1"
    end

    it "should route computers's 'edit' action correctly" do
      route_for(:controller => 'computers', :action => 'edit', :id => '1').should == "/computers/1/edit"
    end

    it "should route computers's 'update' action correctly" do
      route_for(:controller => 'computers', :action => 'update', :id => '1').should == "/computers/1"
    end

    it "should route computers's 'destroy' action correctly" do
      route_for(:controller => 'computers', :action => 'destroy', :id => '1').should == "/computers/1"
    end
  end

  describe "route recognition" do
    it "should generate params for computers's index action from GET /computers" do
      params_from(:get, '/computers').should == {:controller => 'computers', :action => 'index'}
      params_from(:get, '/computers.xml').should == {:controller => 'computers', :action => 'index', :format => 'xml'}
      params_from(:get, '/computers.json').should == {:controller => 'computers', :action => 'index', :format => 'json'}
    end

    it "should generate params for computers's new action from GET /computers" do
      params_from(:get, '/computers/new').should == {:controller => 'computers', :action => 'new'}
      params_from(:get, '/computers/new.xml').should == {:controller => 'computers', :action => 'new', :format => 'xml'}
      params_from(:get, '/computers/new.json').should == {:controller => 'computers', :action => 'new', :format => 'json'}
    end

    it "should generate params for computers's create action from POST /computers" do
      params_from(:post, '/computers').should == {:controller => 'computers', :action => 'create'}
      params_from(:post, '/computers.xml').should == {:controller => 'computers', :action => 'create', :format => 'xml'}
      params_from(:post, '/computers.json').should == {:controller => 'computers', :action => 'create', :format => 'json'}
    end

    it "should generate params for computers's show action from GET /computers/1" do
      params_from(:get , '/computers/1').should == {:controller => 'computers', :action => 'show', :id => '1'}
      params_from(:get , '/computers/1.xml').should == {:controller => 'computers', :action => 'show', :id => '1', :format => 'xml'}
      params_from(:get , '/computers/1.json').should == {:controller => 'computers', :action => 'show', :id => '1', :format => 'json'}
    end

    it "should generate params for computers's edit action from GET /computers/1/edit" do
      params_from(:get , '/computers/1/edit').should == {:controller => 'computers', :action => 'edit', :id => '1'}
    end

    it "should generate params {:controller => 'computers', :action => update', :id => '1'} from PUT /computers/1" do
      params_from(:put , '/computers/1').should == {:controller => 'computers', :action => 'update', :id => '1'}
      params_from(:put , '/computers/1.xml').should == {:controller => 'computers', :action => 'update', :id => '1', :format => 'xml'}
      params_from(:put , '/computers/1.json').should == {:controller => 'computers', :action => 'update', :id => '1', :format => 'json'}
    end

    it "should generate params for computers's destroy action from DELETE /computers/1" do
      params_from(:delete, '/computers/1').should == {:controller => 'computers', :action => 'destroy', :id => '1'}
      params_from(:delete, '/computers/1.xml').should == {:controller => 'computers', :action => 'destroy', :id => '1', :format => 'xml'}
      params_from(:delete, '/computers/1.json').should == {:controller => 'computers', :action => 'destroy', :id => '1', :format => 'json'}
    end
  end

  describe "named routing" do
    before(:each) do
      get :new
    end

    it "should route computers_path() to /computers" do
      computers_path().should == "/computers"
      formatted_computers_path(:format => 'xml').should == "/computers.xml"
      formatted_computers_path(:format => 'json').should == "/computers.json"
    end

    it "should route new_computer_path() to /computers/new" do
      new_computer_path().should == "/computers/new"
      formatted_new_computer_path(:format => 'xml').should == "/computers/new.xml"
      formatted_new_computer_path(:format => 'json').should == "/computers/new.json"
    end

    it "should route computer_(:id => '1') to /computers/1" do
      computer_path(:id => '1').should == "/computers/1"
      formatted_computer_path(:id => '1', :format => 'xml').should == "/computers/1.xml"
      formatted_computer_path(:id => '1', :format => 'json').should == "/computers/1.json"
    end

    it "should route edit_computer_path(:id => '1') to /computers/1/edit" do
      edit_computer_path(:id => '1').should == "/computers/1/edit"
    end
  end

end
