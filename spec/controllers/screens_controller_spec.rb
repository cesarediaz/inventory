require File.dirname(__FILE__) + '/../spec_helper'

# Be sure to include AuthenticatedTestHelper in spec/spec_helper.rb instead
# Then, you can remove it from this and the units test.
include AuthenticatedTestHelper


describe ScreensController do

  def login
    @user = mock_model(User)
    @login_params = { :login => 'admin', :password => 'testing' }
    post :create, @login_params
    User.stub!(:authenticate).with(@login_params[:login], @login_params[:password]).and_return(@user)
    controller.stub!(:logged_in?).and_return(true)
    controller.stub!(:set_user_language).and_return('en')
  end

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

end
