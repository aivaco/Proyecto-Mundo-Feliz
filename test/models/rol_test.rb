require 'test_helper'

class RolTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  test "funciona" do
    p1 = Persona.create(:idPersona => '123', :email => 'lola@lolesca.com', :tipoPersona => 'f')
    f1 = p1.create_fisica(:nombre => 'fulano', :apellido1 => 'mengano', :apellido2 => 'nose', :sexo => 'm', :fechaNac => '1995-05-15')
    c1 = p1.create_cliente(:nombreEmp => 'Red Ribbon')
    pt1= c1.create_portafolio(:fechaCreac => '2015-05-06')
    h1= pt1.hojas.create(:tiempoDef => '2 meses', :razonDeSer => 'porque si')
    h2= pt1.hojas.create(:tiempoDef => '1 dia', :razonDeSer => 'porque si')
    pr1= h1.create_proyecto(:nombre => 'Netflix Azul', :presupuesto => 432000, :precio => 1000000, :estado => 'd')
    
    p2 = Persona.create(:idPersona => '456', :email => 'batman123@batmail.com', :tipoPersona => 'f')
    f2 = p2.create_fisica(:nombre => 'Bruce', :apellido1 => 'Wayne', :apellido2 => 'Nah', :sexo => 'm', :fechaNac => '1975-05-15')
    r1 = f2.create_recurso(almaMater: 'UCR')
    
    p3 = Persona.create(:idPersona => '456', :email => 'no tengo T.T', :tipoPersona => 'f')
    f3 = p3.create_fisica(:nombre => 'Alana', :apellido1 => 'Días', :apellido2 => 'Martínez', :sexo => 'f', :fechaNac => '1986-05-15')
    r2 = f3.create_recurso(almaMater: 'UNA')
    
    pr1.rols.create(recurso: r1, papel: 'Scrum Master')
    pr1.rols.create(recurso: r2, papel: 'Desarrollador')
    
    
    #print pr1.recursos.each {}
    assert pr1.valid?, "pr1 no válido #{pr1.errors.inspect}"
  end
end
