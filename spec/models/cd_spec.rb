require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Cd do
  before(:each) do
  end

  it "should create a new instance given valid attributes" do
    cd = Cd.create({:model => 'Lite-On', :serialnumber => 'a123456' })
    cd.should be_valid
    cd.errors.should be_empty
  end

  it "should not create a new instance given invalid attributes without model" do
    cd = Cd.create({:model => nil, :serialnumber => '1234567890' })
    cd.should have(1).errors_on(:model)
  end

  it "should not create a new instance given invalid attributes without a serial number" do
    cd = Cd.create({:model => 'Lite-On', :serialnumber => nil })
    cd.should have(1).errors_on(:serialnumber)
  end

  it "should not create a new instance given two equals attributes of serial number" do
    cd1 = Cd.create({:model => 'Lite-On', :serialnumber => '1234567890' })
    cd2 = Cd.create({:model => 'Dell', :serialnumber => '1234567890' })
    cd2.should have(1).errors_on(:serialnumber)
  end

end
