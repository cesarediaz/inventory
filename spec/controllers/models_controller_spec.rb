require File.dirname(__FILE__) + '/../spec_helper'

# Be sure to include AuthenticatedTestHelper in spec/spec_helper.rb instead
# Then, you can remove it from this and the units test.
include AuthenticatedTestHelper


describe ModelsController do

  def login
    @user = mock_model(User)
    @login_params = { :login => 'admin', :password => 'testing' }
    post :create, @login_params
    User.stub!(:authenticate).with(@login_params[:login], @login_params[:password]).and_return(@user)
    controller.stub!(:logged_in?).and_return(true)
    controller.stub!(:set_user_language).and_return('en')
  end

  def mock_models
    @model_one = mock_model(Model, :description => "inspiron 1520", :mark_id => 1)
    @model_two = mock_model(Model, :description => "syncmaster3", :mark_id => 2)
    @items = [@model_one, @model_two]
    @models.stub!(:paginate).and_return(@items)
  end

  def do_get_index
    get :index
  end

  describe "get index" do
    before(:each) do
      @model = [mock_model(Model), mock_model(Model), mock_model(Model)]
      Model.stub!(:paginate).and_return(@model)
    end

    it "should be successful" do
      login
      do_get_index
      response.should be_success
    end

    it "should have n records" do
      login
      do_get_index
      @model.should have(3).items
    end

    it "should assings models" do
      login
      assigns[:models].should == @models
    end
  end

end
