require File.dirname(__FILE__) + '/../spec_helper'

# Be sure to include AuthenticatedTestHelper in spec/spec_helper.rb instead
# Then, you can remove it from this and the units test.
include AuthenticatedTestHelper

describe ComputersController do
  fixtures :computers, :screens, :printers

  def login
    @user = mock_model(User)
    @login_params = { :login => 'admin', :password => 'testing' }
    post :create, @login_params
    User.stub!(:authenticate).with(@login_params[:login],
                                   @login_params[:password]).and_return(@user)
    controller.stub!(:logged_in?).and_return(true)
    controller.stub!(:set_user_language).and_return('en')
  end

  before do
  end

  def do_get
    get :new, :place_id => "2"
  end

  it "for this place it should have n computers" do
    login
    do_get
    @computers = Computer.list_for_place_are_not_part_a_workstation(params[:place_id])
    @computers.should have(11).items
  end

  it "for this place it should have n screens" do
    login
    do_get
    @screens = Screen.list_for_place_are_not_part_a_workstation(params[:place_id])
    @screens.should have(11).items
  end

  it "for this place it should have n printers" do
    login
    do_get
    @printers = Printer.list_for_place_are_not_part_a_workstation(params[:place_id])
    @printers.should have(3).items
  end

end
