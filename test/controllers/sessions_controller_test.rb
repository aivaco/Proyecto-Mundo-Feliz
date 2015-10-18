require 'test_helper'

class SessionsControllerTest < ActionController::TestCase
  test "should get view login" do
    get :new
    assert_response :success
  end

end
