require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Cd do
  before(:each) do
  end

  it "should create a new instance given valid attributes" do
    cd = Cd.create({:model_id => 1, :serialnumber => 'a123456', :mark_id => 3 })
    cd.should be_valid
    cd.errors.should be_empty
  end

  it "should not create a new instance given invalid attributes without model_id" do
    cd = Cd.create({:model_id => nil, :serialnumber => '1234567890', :mark_id => 3  })
    cd.should have(1).errors_on(:model_id)
  end

end
