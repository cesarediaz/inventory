require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Dvd do
  before(:each) do
  end

  it "should create a new instance given valid attributes" do
    dvd = Dvd.create({:model_id => 1, :serialnumber => 'a123456', :mark_id => 3 })
    dvd.should be_valid
    dvd.errors.should be_empty
  end

  it "should not create a new instance given invalid attributes without model_id" do
    dvd = Dvd.create({:model_id => nil, :serialnumber => '1234567890', :mark_id => 3  })
    dvd.should have(1).errors_on(:model_id)
  end

end
