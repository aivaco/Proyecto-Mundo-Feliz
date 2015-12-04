require 'test_helper'

class AdministrarEntregableControllerTest < ActionController::TestCase
  test "should get vistageneral" do
    get :vistageneral
    assert_response :success
  end

end
