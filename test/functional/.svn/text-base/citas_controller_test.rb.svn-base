require 'test_helper'

class CitasControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:citas)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_cita
    assert_difference('Cita.count') do
      post :create, :cita => { }
    end

    assert_redirected_to cita_path(assigns(:cita))
  end

  def test_should_show_cita
    get :show, :id => citas(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => citas(:one).id
    assert_response :success
  end

  def test_should_update_cita
    put :update, :id => citas(:one).id, :cita => { }
    assert_redirected_to cita_path(assigns(:cita))
  end

  def test_should_destroy_cita
    assert_difference('Cita.count', -1) do
      delete :destroy, :id => citas(:one).id
    end

    assert_redirected_to citas_path
  end
end
