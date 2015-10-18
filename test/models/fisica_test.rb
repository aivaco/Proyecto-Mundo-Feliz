require 'test_helper'

class FisicaTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
    test "Solo se crea física si existe persona" do
    p1 = Persona.create(:idpersona => '123', :email => 'lola@lolesca.com', :tipopersona => 'f')
    f1 = p1.create_fisica(:nombre => 'fulano', :apellido1 => 'mengano', :apellido2 => 'nose', :sexo => 'm', :fechanac => '1995-05-15')
    assert f1.valid?, "f1 no válida #{f1.errors.inspect}"
    end
  
    test "Presencia de sexo" do
    p1 = Persona.create(:idpersona => '123', :email => 'lola@lolesca.com', :tipopersona => 'f')
    f1 = p1.create_fisica(:nombre => 'fulano', :apellido1 => 'mengano', :apellido2 => 'nose', :sexo => 'Pikachu', :fechanac => '1995-05-15')
    assert !f1.valid?, "f1 no válida #{f1.errors.inspect}"
    end
    
    test "Encontrar con idpersona" do
    p1 = Persona.create(:idpersona => '123', :email => 'lola@lolesca.com', :tipopersona => 'f')
    p2 = Persona.find_by idpersona: '123'
    f1 = p2.create_fisica(:nombre => 'fulano', :apellido1 => 'mengano', :apellido2 => 'nose', :sexo => 'Pikachu', :fechanac => '1995-05-15')
    assert !f1.valid?, "f1 no válida #{f1.errors.inspect}"
    end
end
