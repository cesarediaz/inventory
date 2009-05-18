require File.dirname(__FILE__) + '/../spec_helper'

describe HarddisksController do
  fixtures :harddisks

  describe "get list of harddisks" do
    before do
    end

    def do_get
      get :index
    end

    it "for index list it should have n harddisks" do
      do_get
      @harddisks = Harddisk.find(:all)
      @harddisks.should have(4).items
    end

  end
end
