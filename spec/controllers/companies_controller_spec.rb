require File.dirname(__FILE__) + '/../spec_helper'

# Be sure to include AuthenticatedTestHelper in spec/spec_helper.rb instead
# Then, you can remove it from this and the units test.
include AuthenticatedTestHelper


describe CompaniesController do

  def login
    @user = mock_model(User)
    @login_params = { :login => 'admin', :password => 'testing' }
    post :create, @login_params
    User.stub!(:authenticate).with(@login_params[:login], @login_params[:password]).and_return(@user)
    controller.stub!(:logged_in?).and_return(true)
    controller.stub!(:set_user_language).and_return('en')
  end

  def mock_companies
    @company_one = mock_model(Company, :name => "one", :address => 'address 123', :phone => '123876354',
                              :fax => '123987456', :email => 'one@argentina.gov.ar')
    @company_two = mock_model(Company, :name => "two", :address => 'address 456', :phone => '1238000001',
                              :fax => '123987456', :email => 'two@argentina.gov.ar')
    @companies = [@company_one, @company_two]
    @companies.stub!(:find).and_return(@companies)
  end

  def do_get_index
    get :index
  end


  describe "get index" do
    before(:each) do
      @company = [mock_model(Company)]
      Company.stub!(:paginate).and_return(@company)
    end

    it "should be successful" do
      login
      do_get_index
      response.should be_success
    end

    it "should have n records" do
      login
      do_get_index
      @company.should have(1).items
    end

    it "should assings companys" do
      login
      assigns[:companies].should == @companies
    end

    it "should paginate companies" do
      login
      do_get_index
      Company.should_receive(:paginate).with(:page => nil,
                                             :per_page => 10,
                                             :order => 'created_at DESC')
    end

  end

  describe "handling GET /companies/1/edit" do

    before(:each) do
      login
      mock_companies
      Company.stub!(:find).and_return(@company)
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
      assigns[:company].should equal(@company)
    end

  end

end
