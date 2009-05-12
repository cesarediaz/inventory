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
    assigns[:place_id] = 2
    @places = Place.find(:all)
    @computers = Computer.list_for_place_are_not_part_a_workstation(params[:place_id])
    @screens = Screen.list_for_place_are_not_part_a_workstation(params[:place_id])
    @printers = Printer.list_for_place_are_not_part_a_workstation(params[:place_id])

    @workstation = mock_model(Workstation)
    assigns[:workstation] = @workstation

    assigns[:places] = @places
    assigns[:computers] = @computers
    assigns[:screens] = @screens
    assigns[:printers] = @printers

    @computers.stub!(:list_for_place_are_not_part_a_workstation).with(:place_id => '2').and_return(@computers)
  end

end
