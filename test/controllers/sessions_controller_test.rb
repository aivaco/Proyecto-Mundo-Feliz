require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  test "should get view_login" do
    get :view_login
    assert_response :success
  end

end
