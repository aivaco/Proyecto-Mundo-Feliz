require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  test "debería de tener a mientras" do
    get :mientras
    assert_response :success
  end
end
