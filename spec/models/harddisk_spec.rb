require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')


describe Harddisk do
  before(:each) do
  end

  it "should create a new instance given valid attributes" do
    harddisk = Harddisk.create({:model_id => 1, :serialnumber => 'a123456', :mark_id => 1 })
    harddisk.should be_valid
    harddisk.errors.should be_empty
  end

  it "should not create a new instance given invalid attributes without model" do
    harddisk = Harddisk.create({:model_id => nil, :serialnumber => '1234567890' })
    harddisk.should have(1).errors_on(:model_id)
  end

end
