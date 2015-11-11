require 'test_helper'

class ModuloEntregableControllerTest < ActionController::TestCase
  test "should get view_entregable" do
    get :view_entregable
    assert_response :success
  end

end
