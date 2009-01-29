require 'test_helper'

class HarddisksControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:harddisks)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create harddisk" do
    assert_difference('Harddisk.count') do
      post :create, :harddisk => { }
    end

    assert_redirected_to harddisk_path(assigns(:harddisk))
  end

  test "should show harddisk" do
    get :show, :id => harddisks(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => harddisks(:one).id
    assert_response :success
  end

  test "should update harddisk" do
    put :update, :id => harddisks(:one).id, :harddisk => { }
    assert_redirected_to harddisk_path(assigns(:harddisk))
  end

  test "should destroy harddisk" do
    assert_difference('Harddisk.count', -1) do
      delete :destroy, :id => harddisks(:one).id
    end

    assert_redirected_to harddisks_path
  end
end
