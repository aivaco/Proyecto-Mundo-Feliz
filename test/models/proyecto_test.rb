require 'test_helper'

class ProyectoTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
      test "crear proyecto" do
      p1 = Persona.create(:idpersona => '123', :email => 'lola@lolesca.com', :tipopersona => 'f')
      f1 = p1.create_fisica(:nombre => 'fulano', :apellido1 => 'mengano', :apellido2 => 'nose', :sexo => 'm', :fechanac => '1995-05-15')
      c1 = p1.create_cliente(:nombreEmp => 'Red Ribbon')
      pt1= c1.create_portafolio(:fechaCreac => '2015-05-06')
      h1= pt1.hojas.create(:tiempoDef => '2 meses', :razondeser => 'porque si')
      h2= pt1.hojas.create(:tiempoDef => '1 dia', :razondeser => 'porque si')
      pr1= h1.create_proyecto(:nombre => 'Netflix Azul', :presupuesto => 432000, :precio => 1000000, :estado => 'd')
      assert pr1.valid?, "pr no válida #{pr1.errors.inspect}"
    end
end
