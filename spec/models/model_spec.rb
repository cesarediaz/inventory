require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')


describe Model do
  before(:each) do
  end

  it "should create a new instance given valid attributes" do
    model = Model.create({:description => 'Lite-On', :mark_id => 1 })
    model.should be_valid
    model.errors.should be_empty
  end

  it "should not create a new instance given invalid attributes without description of model" do
    model = Model.create({:description => nil, :mark_id => 1 })
    model.should have(1).errors_on(:description)
  end

  it "should not create a new instance given invalid attributes without mark of model" do
    model = Model.create({:description => 'one model', :mark_id => nil })
    model.should have(2).errors_on(:mark_id)
  end

  it "should not create a new instance given the same data of description" do
    model_one = Model.create({:description => 'one model', :mark_id => 1 })
    model_two = Model.create({:description => 'one model', :mark_id => 2 })
    model_two.should_not be_valid
  end

  it "should not create a new instance if mark_id data is not a number" do
    model = Model.create({:description => 'one model', :mark_id => 'n' })
    model.should have(1).errors_on(:mark_id)
  end



end
