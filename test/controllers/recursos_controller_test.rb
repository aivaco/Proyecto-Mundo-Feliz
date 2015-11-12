require 'test_helper'

class RecursosControllerTest < ActionController::TestCase
  test "should get lista_recursos" do
    get :lista_recursos
    assert_response :success
  end

  test "should get agregar_recurso" do
    get :agregar_recurso
    assert_response :success
  end

  test "should get opciones_recurso" do
    get :opciones_recurso
    assert_response :success
  end

end
