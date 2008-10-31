require 'test_helper'

class TipoEstudiosControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:tipo_estudios)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_tipo_estudio
    assert_difference('TipoEstudio.count') do
      post :create, :tipo_estudio => { }
    end

    assert_redirected_to tipo_estudio_path(assigns(:tipo_estudio))
  end

  def test_should_show_tipo_estudio
    get :show, :id => tipo_estudios(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => tipo_estudios(:one).id
    assert_response :success
  end

  def test_should_update_tipo_estudio
    put :update, :id => tipo_estudios(:one).id, :tipo_estudio => { }
    assert_redirected_to tipo_estudio_path(assigns(:tipo_estudio))
  end

  def test_should_destroy_tipo_estudio
    assert_difference('TipoEstudio.count', -1) do
      delete :destroy, :id => tipo_estudios(:one).id
    end

    assert_redirected_to tipo_estudios_path
  end
end
