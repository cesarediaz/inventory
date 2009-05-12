require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper' )

describe "/workstations/new" do
  it "should use the form partial" do
    template.should_receive(:render).with(:partial => 'form')
    render "/workstations/new"
  end
end

describe "/workstations/_form.html.erb" do
  before do
    @workstation = mock_model(Workstation)
    assigns[:workstation] = @workstation

    @place_one = mock_model(Place, :id => 1, :title => 'oficina')
    @place_two = mock_model(Place, :id => 2, :title => 'deposito')
    @places = [@place_one, @place_two]

    assigns[:places] = @places

    assigns[:place_id] = 1

    @computers = Computer.find(:all)
    assigns[:computers] = @computers

    @screens = Computer.find(:all)
    assigns[:screens] = @screens

    @printers = Computer.find(:all)
    assigns[:printers] = @printers

    render '/workstations/_form.html.erb'
  end

  it "should display form fiels" do

    response.should have_tag("form[action=?][method=post]", workstation_path(@workstation)) do
      with_tag("select[id=places]")
      with_tag("input[id=workstation_submit]")
    end
  end

  it "should display select options" do
    with_tag("option[value=1]")
    with_tag("option[value=2]")
   # with_tag(:select, :html=>"<option>oficina</option>")
   # with_tag(:select, :html=>"<option>deposito</option>")

    response.should have_tag("select") { |elements|
      elements.size.should == 1
      with_tag('select',
               :html=>"<option value=\"\">Select a place</option>\n    \n    <option value=\"1\">\n      oficina\n    </option>\n    \n    <option value=\"2\">\n      deposito\n    </option>")
    }
    assert_select "select" do |elements|
      elements.each do |element|
        assert_select element, "option", 3
      end
    end
  end
end
