require 'test_helper'

class MotherBoardsControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:mother_boards)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create mother_board" do
    assert_difference('MotherBoard.count') do
      post :create, :mother_board => { }
    end

    assert_redirected_to mother_board_path(assigns(:mother_board))
  end

  test "should show mother_board" do
    get :show, :id => mother_boards(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => mother_boards(:one).id
    assert_response :success
  end

  test "should update mother_board" do
    put :update, :id => mother_boards(:one).id, :mother_board => { }
    assert_redirected_to mother_board_path(assigns(:mother_board))
  end

  test "should destroy mother_board" do
    assert_difference('MotherBoard.count', -1) do
      delete :destroy, :id => mother_boards(:one).id
    end

    assert_redirected_to mother_boards_path
  end
end
