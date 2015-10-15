require 'test_helper'

class ModuloClienteControllerTest < ActionController::TestCase
  test "should get modulocliente" do
    get :modulocliente
    assert_response :success
  end

  test "should get listaclientes" do
    get :listaclientes
    assert_response :success
  end

  test "should get actualizarproyectos" do
    get :actualizarproyectos
    assert_response :success
  end

  test "should get nuevocliente" do
    get :nuevocliente
    assert_response :success
  end

end
