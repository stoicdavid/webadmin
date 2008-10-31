require 'test_helper'

class SearchesControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:searches)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_search
    assert_difference('Search.count') do
      post :create, :search => { }
    end

    assert_redirected_to search_path(assigns(:search))
  end

  def test_should_show_search
    get :show, :id => searches(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => searches(:one).id
    assert_response :success
  end

  def test_should_update_search
    put :update, :id => searches(:one).id, :search => { }
    assert_redirected_to search_path(assigns(:search))
  end

  def test_should_destroy_search
    assert_difference('Search.count', -1) do
      delete :destroy, :id => searches(:one).id
    end

    assert_redirected_to searches_path
  end
end
