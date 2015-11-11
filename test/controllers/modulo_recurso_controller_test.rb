require 'test_helper'

class ModuloRecursoControllerTest < ActionController::TestCase
  test "should get view_recurso" do
    get :view_recurso
    assert_response :success
  end

end
