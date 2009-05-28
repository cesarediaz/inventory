require File.expand_path(File.dirname(__FILE__) + '/../../spec_helper' )

describe "places/_links_files_downloads.html.erb" do
  before(:each) do
    render "places/_links_files_downloads.html.erb"
  end

  it "should display two strings to download xls and pdf files" do
    assert_select 'a', 'Descargar un archivo xls'
  end
 end

describe "places/_selector_places_list.html.erb" do
  before(:each) do
    render "places/_selector_places_list.html.erb"
  end

  it "should display text for select" do
    assert_select 'label', 'Seleccione diferentes lugares por descripcion'
  end

  it "should display a select tag with six options" do
    assert_select "select" do |elements|
      elements.each do |element|
        assert_select element, "option", 7
      end
    end
  end

 end
