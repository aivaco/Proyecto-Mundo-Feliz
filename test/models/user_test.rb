require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  def setup
    @user = User.new(usuario: "Example User",  password: "foobar", password_confirmation: "foobar")
  end

   test "El nombre de usuario debe de estar presente." do
    @user.usuario = "     "
    assert_not @user.valid?
  end
  
  test "Un nombre de usuario debe de contener como máximo 20 caracteres." do
    @user.usuario = "a" * 21
    assert_not @user.valid?
  end
  
  test "El usuario debe de ser único" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end
  
  test "La contraseña debe de estar presente." do
    @user.password = @user.password_confirmation = " "*8
    assert_not @user.valid?
  end
  
  test "Una contraseña debe de contener como mínimo 8 caracteres." do
    @user.password = @user.password_confirmation = "a" * 7
    assert_not @user.valid?
  end



=begin  test "Una contraseña debe de contener como máximo 20 caracteres." do
    @user.password = "a" * 21
    assert_not @user.valid?
=end  end


end
