require 'test_helper'

class PlacesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:places)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create place" do
    assert_difference('Place.count') do
      post :create, :place => { }
    end

    assert_redirected_to place_path(assigns(:place))
  end

  test "should show place" do
    get :show, :id => places(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => places(:one).id
    assert_response :success
  end

  test "should update place" do
    put :update, :id => places(:one).id, :place => { }
    assert_redirected_to place_path(assigns(:place))
  end

  test "should destroy place" do
    assert_difference('Place.count', -1) do
      delete :destroy, :id => places(:one).id
    end

    assert_redirected_to places_path
  end
end
