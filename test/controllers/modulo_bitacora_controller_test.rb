require 'test_helper'

class ModuloBitacoraControllerTest < ActionController::TestCase
  test "should get view_bitacora" do
    get :view_bitacora
    assert_response :success
  end

end
