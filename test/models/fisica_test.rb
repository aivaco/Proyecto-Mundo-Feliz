require 'test_helper'

class FisicaTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
    test "Solo se crea física si existe persona" do
    p1 = Persona.create(:idPersona => '123', :email => 'lola@lolesca.com', :tipoPersona => 'f')
    f1 = p1.create_fisica(:nombre => 'fulano', :apellido1 => 'mengano', :apellido2 => 'nose', :sexo => 'm', :fechaNac => '1995-05-15')
    assert f1.valid?, "f1 no válida #{f1.errors.inspect}"
    end
  
    test "Presencia de sexo f o m" do
    p1 = Persona.create(:idPersona => '123', :email => 'lola@lolesca.com', :tipoPersona => 'f')
    f1 = p1.create_fisica(:nombre => 'fulano', :apellido1 => 'mengano', :apellido2 => 'nose', :sexo => 'Pikachu', :fechaNac => '1995-05-15')
    assert !f1.valid?, "f1 no válida #{f1.errors.inspect}"
    end
    
    test "Encontrar con idPersona" do
    p1 = Persona.create(:idPersona => '123', :email => 'lola@lolesca.com', :tipoPersona => 'f')
    p2 = Persona.find_by idpersona: '123'
    f1 = p2.create_fisica(:nombre => 'fulano', :apellido1 => 'mengano', :apellido2 => 'nose', :sexo => 'Pikachu', :fechaNac => '1995-05-15')
    assert !f1.valid?, "f1 no válida #{f1.errors.inspect}"
    end
end
