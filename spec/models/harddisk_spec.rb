require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')


describe Harddisk do
  before(:each) do
  end

  it "should create a new instance given valid attributes" do
    harddisk = Harddisk.create({:model => 'Lite-On', :serialnumber => 'a123456' })
    harddisk.should be_valid
    harddisk.errors.should be_empty
  end

  it "should not create a new instance given invalid attributes without model" do
    harddisk = Harddisk.create({:model => nil, :serialnumber => '1234567890' })
    harddisk.should have(1).errors_on(:model)
  end

  it "should not create a new instance given invalid attributes without a serial number" do
    harddisk = Harddisk.create({:model => 'Lite-On', :serialnumber => nil })
    harddisk.should have(1).errors_on(:serialnumber)
  end

  it "should not create a new instance given two equals attributes of serial number" do
    harddisk1 = Harddisk.create({:model => 'Lite-On', :serialnumber => '1234567890' })
    harddisk2 = Harddisk.create({:model => 'Dell', :serialnumber => '1234567890' })
    harddisk2.should have(1).errors_on(:serialnumber)
  end

end
