require 'test_helper'

class WorkstationsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:workstations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create workstation" do
    assert_difference('Workstation.count') do
      post :create, :workstation => { }
    end

    assert_redirected_to workstation_path(assigns(:workstation))
  end

  test "should show workstation" do
    get :show, :id => workstations(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => workstations(:one).id
    assert_response :success
  end

  test "should update workstation" do
    put :update, :id => workstations(:one).id, :workstation => { }
    assert_redirected_to workstation_path(assigns(:workstation))
  end

  test "should destroy workstation" do
    assert_difference('Workstation.count', -1) do
      delete :destroy, :id => workstations(:one).id
    end

    assert_redirected_to workstations_path
  end
end
