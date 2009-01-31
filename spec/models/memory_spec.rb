require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Memory do
  before(:each) do
  end

  it "should create a new instance given valid attributes" do
    memory = Memory.create({:model => 'Kingston', :serialnumber => 'a123456' })
    memory.should be_valid
    memory.errors.should be_empty
  end

  it "should not create a new instance given invalid attributes without model" do
    memory = Memory.create({:model => nil, :serialnumber => '1234567890' })
    memory.should have(1).errors_on(:model)
  end

  it "should not create a new instance given invalid attributes without a serial number" do
    memory = Memory.create({:model => 'Kingston', :serialnumber => nil })
    memory.should have(1).errors_on(:serialnumber)
  end

  it "should not create a new instance given two equals attributes of serial number" do
    memory1 = Memory.create({:model => 'Kingston', :serialnumber => '1234567890' })
    memory2 = Memory.create({:model => 'Dell', :serialnumber => '1234567890' })
    memory2.should have(1).errors_on(:serialnumber)
  end

end
