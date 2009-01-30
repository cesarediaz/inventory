require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

def create_computer(options)
  Computer.create(options)
end

describe Computer do

  it "should not be valid without the name computer" do
    computer = create_computer({:name => nil, :ip => '123.232.23.32', :mac => '13:23:43:15:53:30'})
    computer.should_not be_valid
    computer.should have(1).errors_on(:name)
  end

  it "should not be valid without ip" do
    computer = create_computer({:name => 'pc', :ip => nil, :mac => '13:23:43:15:53:30'})
    computer.should have(3).errors_on(:ip)
  end

  it "should not be valid without mac" do
    computer = create_computer({:name => 'pc', :ip => '123.232.23.32', :mac => nil})
    computer.should have(2).errors_on(:mac)
  end

  it "should not be valid if ip have a letter " do
    computer =  create_computer(:ip => "23.43.234.34f")
    computer.should have(1).errors_on(:ip)
  end

  it "should not be valid if ip have a size is less than eigth positions" do
    computer =  create_computer(:ip => "23.43.234.34f")
    computer.should have(1).errors_on(:ip)
  end

  it "should not be valid if ip have a size is higer than fifteen positions" do
    computer =  create_computer(:ip => "223.132.00000.343")
    computer.should have(2).errors_on(:ip)
  end

  it "should not be valid mac with a bad format" do
    computer = create_computer({:name => 'pc', :ip => "23.43.234.34", :mac => '13-23-43-15-53.30'})
    computer.should have(1).errors_on(:mac)
  end

  it "should not be valid mac with a bad size" do
    computer = create_computer({:name => 'pc', :ip => "23.43.234.34", :mac => '13:23:43:15:53:301'})
    computer.should have(1).errors_on(:mac)
  end


  it "should be valid " do
    computer = create_computer({:name => 'name', :ip => '123.232.23.32', :mac => '13:23:43:15:53:30'})
    computer.should be_valid
    computer.errors.should be_empty
  end

  it "should not be valid with the same mac data" do
    computer1 = create_computer({:name => 'name1', :ip => '123.232.23.31', :mac => '13:23:43:15:53:30'})
    computer2 = create_computer({:name => 'name2', :ip => '123.232.23.32', :mac => '13:23:43:15:53:30'})
    computer2.should have(1).errors_on(:mac)
  end

  it "should not be valid with the same ip data" do
    computer1 = create_computer({:name => 'name1', :ip => '123.232.23.31', :mac => '13:23:43:15:53:30'})
    computer2 = create_computer({:name => 'name2', :ip => '123.232.23.31', :mac => '13:23:43:15:53:31'})
    computer2.should have(1).errors_on(:ip)
  end

  it "should not be valid with the same name data" do
    computer1 = create_computer({:name => 'name1', :ip => '123.232.23.30', :mac => '13:23:43:15:53:30'})
    computer2 = create_computer({:name => 'name1', :ip => '123.232.23.31', :mac => '13:23:43:15:53:31'})
    computer2.should have(1).errors_on(:name)
  end

end
