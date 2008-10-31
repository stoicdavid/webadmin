require 'test_helper'

class ConsultasControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:consultas)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_consulta
    assert_difference('Consulta.count') do
      post :create, :consulta => { }
    end

    assert_redirected_to consulta_path(assigns(:consulta))
  end

  def test_should_show_consulta
    get :show, :id => consultas(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => consultas(:one).id
    assert_response :success
  end

  def test_should_update_consulta
    put :update, :id => consultas(:one).id, :consulta => { }
    assert_redirected_to consulta_path(assigns(:consulta))
  end

  def test_should_destroy_consulta
    assert_difference('Consulta.count', -1) do
      delete :destroy, :id => consultas(:one).id
    end

    assert_redirected_to consultas_path
  end
end
