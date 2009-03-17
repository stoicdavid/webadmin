require 'test_helper'

class IntersControllerTest < ActionController::TestCase
  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:inters)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create inter" do
    assert_difference('Inter.count') do
      post :create, :inter => { }
    end

    assert_redirected_to inter_path(assigns(:inter))
  end

  test "should show inter" do
    get :show, :id => inters(:one).id
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => inters(:one).id
    assert_response :success
  end

  test "should update inter" do
    put :update, :id => inters(:one).id, :inter => { }
    assert_redirected_to inter_path(assigns(:inter))
  end

  test "should destroy inter" do
    assert_difference('Inter.count', -1) do
      delete :destroy, :id => inters(:one).id
    end

    assert_redirected_to inters_path
  end
end
