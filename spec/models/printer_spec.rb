require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Printer do
  before(:each) do
  end

  it "should create a new instance given valid attributes" do
    printer = Printer.create({:model_id => 1, :serialnumber => 'a123456',
                               :place_id => 1, :mark_id => 1 })
    printer.should be_valid
    printer.errors.should be_empty
  end

  it "should not create a new instance given invalid attributes without model_id" do
    printer = Printer.create({:model_id => nil, :serialnumber => '1234567890', :place_id => 1,
                               :mark_id => 1   })
    printer.should have(1).errors_on(:model_id)
  end

  it "should not create a new instance given invalid attributes without serial number " do
    printer = Printer.create({:model_id => 1, :serialnumber => nil, :place_id => 1,
                               :mark_id => 1   })
    printer.should have(1).errors_on(:serialnumber)
  end

  it "should not create a new instance given two equals attributes of serial number" do
    printer1 = Printer.create({:model_id => 1, :serialnumber => '1234567890', :place_id => 1 \
                                , :mark_id => 1   })
    printer2 = Printer.create({:model_id => 1, :serialnumber => '1234567890', :place_id => 1 \
                                , :mark_id => 1   })
    printer2.should have(1).errors_on(:serialnumber)
  end

end
