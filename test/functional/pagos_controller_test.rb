require 'test_helper'

class PagosControllerTest < ActionController::TestCase
  def test_should_get_index
    get :index
    assert_response :success
    assert_not_nil assigns(:pagos)
  end

  def test_should_get_new
    get :new
    assert_response :success
  end

  def test_should_create_pago
    assert_difference('Pago.count') do
      post :create, :pago => { }
    end

    assert_redirected_to pago_path(assigns(:pago))
  end

  def test_should_show_pago
    get :show, :id => pagos(:one).id
    assert_response :success
  end

  def test_should_get_edit
    get :edit, :id => pagos(:one).id
    assert_response :success
  end

  def test_should_update_pago
    put :update, :id => pagos(:one).id, :pago => { }
    assert_redirected_to pago_path(assigns(:pago))
  end

  def test_should_destroy_pago
    assert_difference('Pago.count', -1) do
      delete :destroy, :id => pagos(:one).id
    end

    assert_redirected_to pagos_path
  end
end
