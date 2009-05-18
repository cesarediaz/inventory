require File.dirname(__FILE__) + '/../spec_helper'

describe MemoriesController do
  fixtures :memories

  describe "get list of memories" do
    before do
    end

    def do_get
      get :index
    end

    it "for index list it should have n memories" do
      do_get
      @memories = Memory.find(:all)
      @memories.should have(4).items
    end

  end
end
