require 'test_helper'

class ReferenciasControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:referencias)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_referencia
    assert_difference('Referencia.count') do
      post :create, :referencia => { }
    end

    assert_redirected_to referencia_path(assigns(:referencia))
  end

  def test_should_show_referencia
    get :show, :id => referencias(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => referencias(:one).id
    assert_response :success
  end

  def test_should_update_referencia
    put :update, :id => referencias(:one).id, :referencia => { }
    assert_redirected_to referencia_path(assigns(:referencia))
  end

  def test_should_destroy_referencia
    assert_difference('Referencia.count', -1) do
      delete :destroy, :id => referencias(:one).id
    end

    assert_redirected_to referencias_path
  end
end
