require 'test_helper'

class CompaniesControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:companies)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create company" do
    assert_difference('Company.count') do
      post :create, :company => { }
    end

    assert_redirected_to company_path(assigns(:company))
  end

  test "should show company" do
    get :show, :id => companies(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => companies(:one).id
    assert_response :success
  end

  test "should update company" do
    put :update, :id => companies(:one).id, :company => { }
    assert_redirected_to company_path(assigns(:company))
  end

  test "should destroy company" do
    assert_difference('Company.count', -1) do
      delete :destroy, :id => companies(:one).id
    end

    assert_redirected_to companies_path
  end
end
