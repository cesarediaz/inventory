require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper' )

describe "/workstations/new" do
  it "should use the form partial" do
    template.should_receive(:render).with(:partial => 'form')
    render "/workstations/new"
  end
end


describe "/workstations/_form.html.erb" do
  fixtures :computers, :screens, :printers, :places

  def login
    @user = mock_model(User)
    @login_params = { :login => 'admin', :password => 'testing' }
    post :create, @login_params
    User.stub!(:authenticate).with(@login_params[:login],
                                   @login_params[:password]).and_return(@user)
    controller.stub!(:logged_in?).and_return(true)
    controller.stub!(:set_user_language).and_return('en')
  end

  def do_get
    get :new, :place_id => "2"
  end

  before(:each) do
    @workstation = mock_model(Workstation)
    assigns[:workstation] = @workstation

    @places = Place.find(:all)
    assigns[:places] = @places

    assigns[:place_id] = 2

    @computers = Computer.list_for_place_are_not_part_a_workstation(params[:place_id])
    assigns[:computers] = @computers

    @screens = Screen.list_for_place_are_not_part_a_workstation(params[:place_id])
    assigns[:screens] = @screens

    @printers = Printer.list_for_place_are_not_part_a_workstation(params[:place_id])
    assigns[:printers] = @printers

  end

  it "should display form fiels" do
    render '/workstations/_form.html.erb'
    response.should have_tag("form[action=?][method=post]", workstation_path(@workstation)) do
      with_tag("select[id=places]")
      with_tag("input[id=workstation_submit]")
    end
  end

  it "should display select options for places" do
    render '/workstations/_form.html.erb'

    with_tag("option[value=1]")

    response.should have_tag("select") { |elements|
      elements.size.should == 1
      with_tag('select',
               :html=>"<option value=\"\">Seleccione un lugar</option>\n    \n    <option value=\"1\">\n      Oficina de Personal\n    </option>\n    \n    <option value=\"2\">\n      Oficina de Pasantias\n    </option>\n    \n    <option value=\"3\">\n      Sala A\n    </option>\n    \n    <option value=\"4\">\n      Sala B\n    </option>\n    \n    <option value=\"5\">\n      Deposito Informatica\n    </option>\n    \n    <option value=\"6\">\n      Contabilidad\n    </option>\n    \n    <option value=\"7\">\n      Cooperadora\n    </option>\n    \n    <option value=\"8\">\n      Finanzas\n    </option>\n    \n    <option value=\"9\">\n      Creditos\n    </option>\n    \n    <option value=\"10\">\n      Financiera\n    </option>\n    \n    <option value=\"11\">\n      Sala C\n    </option>")
    }

    assert_select "select" do |elements|
      elements.each do |element|
        assert_select element, "option", 12
      end
    end


  end


end
