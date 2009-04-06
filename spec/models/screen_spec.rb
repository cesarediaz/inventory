require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Screen do
  before(:each) do
  end

  it "should create a new instance given valid attributes" do
    screen = Screen.create({:model => 'SyncMaster 3v', :serialnumber => 'a123456',
                             :place_id => 1, :mark_id => 1  })
    screen.should be_valid
    screen.errors.should be_empty
  end

  it "should not create a new instance given invalid attributes without model" do
    screen = Screen.create({:model => nil, :serialnumber => '1234567890',
                             :place_id => 1, :mark_id => 1  })
    screen.should have(1).errors_on(:model)
  end

  it "should not create a new instance given invalid attributes without serial number" do
    screen = Screen.create({:model => 'SyncMaster 3v', :serialnumber => nil,
                             :place_id => 1, :mark_id => 1  })
    screen.should have(1).errors_on(:serialnumber)
  end

  it "should not create a new instance given two equals attributes of serial number" do
    screen1 = Screen.create({:model => 'SyncMaster 3v', :serialnumber => '1234567890',
                              :place_id => 1, :mark_id => 1  })
    screen2 = Screen.create({:model => 'SyncMaster 3v', :serialnumber => '1234567890',
                              :place_id => 1, :mark_id => 1  })
    screen2.should have(1).errors_on(:serialnumber)
  end

end
