require 'test_helper'

class PrintersControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:printers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create printer" do
    assert_difference('Printer.count') do
      post :create, :printer => { }
    end

    assert_redirected_to printer_path(assigns(:printer))
  end

  test "should show printer" do
    get :show, :id => printers(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => printers(:one).id
    assert_response :success
  end

  test "should update printer" do
    put :update, :id => printers(:one).id, :printer => { }
    assert_redirected_to printer_path(assigns(:printer))
  end

  test "should destroy printer" do
    assert_difference('Printer.count', -1) do
      delete :destroy, :id => printers(:one).id
    end

    assert_redirected_to printers_path
  end
end
