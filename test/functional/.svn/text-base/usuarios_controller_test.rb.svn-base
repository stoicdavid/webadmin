require 'test_helper'

class UsuariosControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:usuarios)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_usuario
    assert_difference('Usuario.count') do
      post :create, :usuario => { }
    end

    assert_redirected_to usuario_path(assigns(:usuario))
  end

  def test_should_show_usuario
    get :show, :id => usuarios(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => usuarios(:one).id
    assert_response :success
  end

  def test_should_update_usuario
    put :update, :id => usuarios(:one).id, :usuario => { }
    assert_redirected_to usuario_path(assigns(:usuario))
  end

  def test_should_destroy_usuario
    assert_difference('Usuario.count', -1) do
      delete :destroy, :id => usuarios(:one).id
    end

    assert_redirected_to usuarios_path
  end
end
