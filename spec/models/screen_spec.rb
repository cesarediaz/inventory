require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Screen do
  before(:each) do
  end

  it "should create a new instance given valid attributes" do
    screen = Screen.create({:model_id => 1, :serialnumber => 'a123456',
                             :place_id => 1, :mark_id => 1  })
    screen.should be_valid
    screen.errors.should be_empty
  end

  it "should not create a new instance given invalid attributes without model_id" do
    screen = Screen.create({:model_id => nil, :serialnumber => '1234567890',
                             :place_id => 1, :mark_id => 1  })
    screen.should have(1).errors_on(:model_id)
  end

end
