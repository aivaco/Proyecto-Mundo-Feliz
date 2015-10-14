require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  #Método para testear el inicio de sesión

  test "login with invalid information" do
    get login_path
    assert_template 'sessions/view_login'
    post login_path, session: { usuario: "", password: "" }
    assert_template 'sessions/view_login'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end
  

end

