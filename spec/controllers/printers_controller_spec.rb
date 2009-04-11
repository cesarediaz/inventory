require File.dirname(__FILE__) + '/../spec_helper'

# Be sure to include AuthenticatedTestHelper in spec/spec_helper.rb instead
# Then, you can remove it from this and the units test.
include AuthenticatedTestHelper


describe PrintersController do

  def login
    @user = mock_model(User)
    @login_params = { :login => 'admin', :password => 'testing' }
    post :create, @login_params
    User.stub!(:authenticate).with(@login_params[:login], @login_params[:password]).and_return(@user)
    controller.stub!(:logged_in?).and_return(true)
    controller.stub!(:set_user_language).and_return('en')
  end

  def mock_printers
    @printer_one = mock_model(Printer, :id => 1, :model => "Laser 1100", :sn => '12345678', :available => true)
    @printer_two = mock_model(Printer, :id => 2, :model => "pc_2", :sn => '01020304', :available => false)
    @printers = [@printer_one, @printer_two]
    Printer.stub!(:search).and_return(@printers)
    @printers.stub!(:find).and_return(@printers)
  end

  def do_get_index
    get :index
  end

  describe "get index" do
    before(:each) do
      @printer = [mock_model(Printer),mock_model(Printer),mock_model(Printer)]
      Printer.stub!(:paginate).and_return(@printer)
    end

    it "should be successful" do
      login
      do_get_index
      response.should be_success
    end

    it "should have n records" do
      login
      do_get_index
      @printer.should have(3).items
    end

    it "should assings printers" do
      login
      assigns[:printers].should == @printers
    end

    it "should be unsuccessful without logged in and get sessions new" do
      response.should_not be_success
      get 'sessions/new'
    end

    it "should paginate printers" do
      login
      do_get_index
      Printer.should_receive(:paginate).with(:page => nil,
                                              :per_page => 10,
                                              :order => 'created_at DESC')
    end

  end

  describe "handling GET search" do
    before(:each) do
      login
      mock_printers
    end

    def do_get_search
      get 'printers/search'
    end

    it "should be successful" do
      do_get_search
      response.should be_success
    end

    it "should render edit template" do
      do_get_search
      response.should render_template('search')
    end

  end


  describe "handling GET /printers/1/edit" do

      before(:each) do
        login
        mock_printers
        Printer.stub!(:find).and_return(@printer)
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

      it "should assign the found Printer for the view" do
        do_get
        assigns[:printer].should equal(@printer)
      end

    end

end
