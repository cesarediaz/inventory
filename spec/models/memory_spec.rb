require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Memory do
  before(:each) do
  end

  it "should create a new instance given valid attributes" do
    memory = Memory.create({:model_id => 1, :serialnumber => 'a123456', :mark_id => 1 })
    memory.should be_valid
    memory.errors.should be_empty
  end

  it "should not create a new instance given invalid attributes without model" do
    memory = Memory.create({:model_id => nil, :serialnumber => '1234567890' })
    memory.should have(1).errors_on(:model_id)
  end

  it "should not create a new instance given invalid attributes without a serial number" do
    memory = Memory.create({:model_id => 1, :serialnumber => nil })
    memory.should have(1).errors_on(:serialnumber)
  end

  it "should not create a new instance given two equals attributes of serial number" do
    memory1 = Memory.create({:model_id => 1, :serialnumber => '1234567890', :mark_id => 1 })
    memory2 = Memory.create({:model_id => 2, :serialnumber => '1234567890', :mark_id => 2 })
    memory2.should have(1).errors_on(:serialnumber)
  end

end
