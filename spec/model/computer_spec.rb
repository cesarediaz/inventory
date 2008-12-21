require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

def create_computer(options = {})
  Computer.create({:name => 'computer01',
                    :ip => '123.232.23.32',
                    :mac => '00:21:9b:f7:d8:6b'})
end

describe Computer do

  it "should not be valid without the name computer" do
    computer = create_computer({:name => nil})
    computer.should_not be_valid
    computer.should have(1).errors_on(:name)
  end

  it "should not be valid without ip" do
    computer = create_computer(:ip => nil)
    computer.should have(2).errors_on(:ip)
  end

  it "should not be valid without mac" do
    computer = create_computer(:mac => nil)
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
    computer.should have(1).errors_on(:ip)
  end


  it "should be valid " do
    create_computer.should be_valid
    create_computer.errors.should be_empty
  end


end
