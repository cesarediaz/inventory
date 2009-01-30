require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Place do
  before(:each) do
  end

  it "should create a new instance given valid attributes" do
    place = Place.create({:title => 'Office People', :description => 'office' })
    place.should be_valid
    place.errors.should be_empty
  end

  it "should not create a new instance given invalid attributes without title" do
    place = Place.create({:title => nil, :description => 'office' })
    place.should have(2).errors_on(:title)
  end

  it "should not create a new instance given invalid attributes without description" do
    place = Place.create({:title => 'Office People', :description => nil })
    place.should have(1).errors_on(:description)
  end

  it "should not create a new instance given invalid attributes with a title with only 1 letter" do
    place = Place.create({:title => '', :description => 'room' })
    place.should have(2).errors_on(:title)
  end

  it "should not create a new instance given invalid attributes with a title with more than 100 letter" do
    place = Place.create({:title => '0123456789
                                     1123456789
                                     2123456789
                                     3123456789
                                     4123456789
                                     5123456789
                                     6123456789
                                     7123456789
                                     8123456789
                                     9123456789 y mas', :description => 'room' })
    place.should have(1).errors_on(:title)
  end


end
