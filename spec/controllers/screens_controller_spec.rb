require File.dirname(__FILE__) + '/../spec_helper'

# Be sure to include AuthenticatedTestHelper in spec/spec_helper.rb instead
# Then, you can remove it from this and the units test.
include AuthenticatedTestHelper

def login
  @user = mock_model(User)
  @login_params = { :login => 'admin', :password => 'testing' }
  post :create, @login_params
  User.stub!(:authenticate).with(@login_params[:login], @login_params[:password]).and_return(@user)
  controller.stub!(:logged_in?).and_return(true)
  controller.stub!(:set_user_language).and_return('en')
end

describe ScreensController do
  fixtures :screens

  describe "get list of screens" do
    before do
    end

    def do_get
      get :index
    end

    def do_get_office_one
      get :index, :place_id => "1"
    end

    def do_get_office_two
      get :index, :place_id => "2"
    end

    it "it should not have screens" do
      login
      do_get_office_one
      @screens = Screen.list_for_place(params[:place_id])
      @screens.should have(0).items
    end

    it "it should have n screens" do
      login
      do_get_office_two
      @screens = Screen.list_for_place(params[:place_id])
      @screens.should have(11).items
    end

    it "for index list it should have n screens" do
      login
      do_get
      @screens = Screen.find(:all)
      @screens.should have(11).items
    end

  end
end

describe ScreensController do

  def mock_screens
    @screen_one = mock_model(Screen, :model => "pc_1", :sn => '12345678', :available => true)
    @screen_two = mock_model(Screen, :model => "pc_2", :sn => '01020304', :available => false)
    @screens = [@screen_one, @screen_two]
    @screens_available = [@screen_one]
    @screens_unavailable = [@screen_two]
    Screen.stub!(:available).and_return(@screens_available)
    Screen.stub!(:unavailable).and_return(@screens_unavailable)
    @screens.stub!(:find).and_return(@screens)
  end

  def do_get_index
    get :index
  end

  describe "get index" do
    before(:each) do
      @screen = [mock_model(Screen)]
      Screen.stub!(:paginate).and_return(@screen)
    end

    it "should be successful" do
      login
      do_get_index
      response.should be_success
    end

    it "should have n records" do
      login
      do_get_index
      @screen.should have(1).items
    end

    it "should assings screens" do
      login
      assigns[:screens].should == @screens
    end

    it "should be unsuccessful without logged in and get sessions new" do
      response.should_not be_success
      get 'sessions/new'
    end

    it "should paginate screens" do
      login
      do_get_index
      Screen.should_receive(:paginate).with(:page => nil,
                                              :per_page => 10,
                                              :order => 'created_at DESC')
    end

  end


  describe "handling GET /screens/1/edit" do

      before(:each) do
        login
        mock_screens
        Screen.stub!(:find).and_return(@screen)
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

      it "should assign the found Screen for the view" do
        do_get
        assigns[:screen].should equal(@screen)
      end

    end

end
