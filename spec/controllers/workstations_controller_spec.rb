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


  describe "get list of computers, screens and printers" do
    before do
    end

    def do_get_for_office_one
      get :new, :place_id => "1"
    end

    def do_get_for_office_two
      get :new, :place_id => "2"
    end

    it "for  office one it should have n computers" do
      login
      do_get_for_office_one
      @computers = Computer.list_for_place_are_not_part_a_workstation(params[:place_id])
      @computers.should have(1).items
    end

    it "for office two it should have n computers" do
      login
      do_get_for_office_two
      @computers = Computer.list_for_place_are_not_part_a_workstation(params[:place_id])
      @computers.should have(11).items
    end

    it "for office one it should have n screens" do
      login
      do_get_for_office_one
      @screens = Screen.list_for_place_are_not_part_a_workstation(params[:place_id])
      @screens.should have(0).items
    end

    it "for office two it should have n screens" do
      login
      do_get_for_office_two
      @screens = Screen.list_for_place_are_not_part_a_workstation(params[:place_id])
      @screens.should have(11).items
    end

    it "for office one it should have n printers" do
      login
      do_get_for_office_one
      @printers = Printer.list_for_place_are_not_part_a_workstation(params[:place_id])
      @printers.should have(0).items
    end

    it "for office two it should have n printers" do
      login
      do_get_for_office_two
      @printers = Printer.list_for_place_are_not_part_a_workstation(params[:place_id])
      @printers.should have(3).items
    end
  end
end
