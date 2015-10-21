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
    @user.usuario = "a" * 100
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
  
  test "Inició Sesión? Retorna falso para un usuario que tiene null en password_digest" do
    assert_not @user.authenticated?(:remember, '')
  end


  test 'persona' do
    p1 = Persona.create(:idPersona => '123', :email => 'lola@lolesca.com', :tipoPersona => 'f')
    f1 = p1.create_fisica(:nombre => 'fulano', :apellido1 => 'mengano', :apellido2 => 'nose', :sexo => 'Pikachu', :fechaNac => '1995-05-15')
    u1 = p1.create_user(usuario: 'dadad', password: '12345678')
    assert u1.valid?, "u1 no válida #{u1.errors.inspect}"
  end
=begin  test "Una contraseña debe de contener como máximo 20 caracteres." do
    @user.password = "a" * 21
    assert_not @user.valid?
=end  end


end
