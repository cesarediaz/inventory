require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Dvd do
  before(:each) do
  end

  it "should create a new instance given valid attributes" do
    dvd = Dvd.create({:model => 'Lite-On', :serialnumber => 'a123456', :mark_id => 1 })
    dvd.should be_valid
    dvd.errors.should be_empty
  end

  it "should not create a new instance given invalid attributes without model" do
    dvd = Dvd.create({:model => nil, :serialnumber => '1234567890', :mark_id => 1  })
    dvd.should have(1).errors_on(:model)
  end

  it "should not create a new instance given invalid attributes without a serial number" do
    dvd = Dvd.create({:model => 'Lite-On', :serialnumber => nil, :mark_id => 1  })
    dvd.should have(1).errors_on(:serialnumber)
  end

  it "should not create a new instance given two equals attributes of serial number" do
    dvd1 = Dvd.create({:model => 'Lite-On', :serialnumber => '1234567890', :mark_id => 1  })
    dvd2 = Dvd.create({:model => 'Dell', :serialnumber => '1234567890', :mark_id => 1  })
    dvd2.should have(1).errors_on(:serialnumber)
  end

end
