require File.dirname(__FILE__) + '/../spec_helper'

# Be sure to include AuthenticatedTestHelper in spec/spec_helper.rb instead
# Then, you can remove it from this and the units test.

describe MotherBoardsController do
  fixtures :mother_boards

  describe "get list of motherboards" do
    before do
    end

    def do_get
      get :index
    end

    it "for index list it should have n motherboards" do
      do_get
      @motherboards = MotherBoard.find(:all)
      @motherboards.should have(4).items
    end

  end
end
