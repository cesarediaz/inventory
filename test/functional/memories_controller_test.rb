require 'test_helper'

class MemoriesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:memories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create memory" do
    assert_difference('Memory.count') do
      post :create, :memory => { }
    end

    assert_redirected_to memory_path(assigns(:memory))
  end

  test "should show memory" do
    get :show, :id => memories(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => memories(:one).id
    assert_response :success
  end

  test "should update memory" do
    put :update, :id => memories(:one).id, :memory => { }
    assert_redirected_to memory_path(assigns(:memory))
  end

  test "should destroy memory" do
    assert_difference('Memory.count', -1) do
      delete :destroy, :id => memories(:one).id
    end

    assert_redirected_to memories_path
  end
end
