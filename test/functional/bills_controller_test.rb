require 'test_helper'

class BillsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:bills)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create bill" do
    assert_difference('Bill.count') do
      post :create, :bill => { }
    end

    assert_redirected_to bill_path(assigns(:bill))
  end

  test "should show bill" do
    get :show, :id => bills(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => bills(:one).id
    assert_response :success
  end

  test "should update bill" do
    put :update, :id => bills(:one).id, :bill => { }
    assert_redirected_to bill_path(assigns(:bill))
  end

  test "should destroy bill" do
    assert_difference('Bill.count', -1) do
      delete :destroy, :id => bills(:one).id
    end

    assert_redirected_to bills_path
  end
end
