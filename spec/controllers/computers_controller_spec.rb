require File.dirname(__FILE__) + '/../spec_helper'

# Be sure to include AuthenticatedTestHelper in spec/spec_helper.rb instead
# Then, you can remove it from this and the units test.
include AuthenticatedTestHelper




describe ComputersController do
  integrate_views
  fixtures :computers


  it "should set @computers when accessing GET /index" do
    get :index
    assigns[:computers].should_not be_nil
    response.should be_success
  end


#   it 'requires login on signup' do
#     lambda do
#       create_computer(:login => nil)
#       assigns[:computer].errors.on(:login).should_not be_nil
#       response.should be_success
#     end.should_not change(Computer, :count)
#   end

#   it 'requires password on signup' do
#     lambda do
#       create_computer(:password => nil)
#       assigns[:computer].errors.on(:password).should_not be_nil
#       response.should be_success
#     end.should_not change(Computer, :count)
#   end

#   it 'requires password confirmation on signup' do
#     lambda do
#       create_computer(:password_confirmation => nil)
#       assigns[:computer].errors.on(:password_confirmation).should_not be_nil
#       response.should be_success
#     end.should_not change(Computer, :count)
#   end

#   it 'requires email on signup' do
#     lambda do
#       create_computer(:email => nil)
#       assigns[:computer].errors.on(:email).should_not be_nil
#       response.should be_success
#     end.should_not change(Computer, :count)
#   end



  def create_computer(options = {})
    post :create, :computer => { :login => 'quire', :email => 'quire@example.com',
      :password => 'quire69', :password_confirmation => 'quire69' }.merge(options)
  end
end

describe ComputersController do
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
