require 'test_helper'

class PacientesControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:pacientes)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_paciente
    assert_difference('Paciente.count') do
      post :create, :paciente => { }
    end

    assert_redirected_to paciente_path(assigns(:paciente))
  end

  def test_should_show_paciente
    get :show, :id => pacientes(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => pacientes(:one).id
    assert_response :success
  end

  def test_should_update_paciente
    put :update, :id => pacientes(:one).id, :paciente => { }
    assert_redirected_to paciente_path(assigns(:paciente))
  end

  def test_should_destroy_paciente
    assert_difference('Paciente.count', -1) do
      delete :destroy, :id => pacientes(:one).id
    end

    assert_redirected_to pacientes_path
  end
end
