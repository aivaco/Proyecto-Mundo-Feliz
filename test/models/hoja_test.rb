require 'test_helper'

class HojaTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
    test "crear hoja" do
      p1 = Persona.create(:idpersona => '123', :email => 'lola@lolesca.com', :tipopersona => 'f')
      f1 = p1.create_fisica(:nombre => 'fulano', :apellido1 => 'mengano', :apellido2 => 'nose', :sexo => 'm', :fechanac => '1995-05-15')
      c1 = p1.create_cliente(:nombreEmp => 'Red Ribbon')
      pt1= c1.create_portafolio(:fechaCreac => '2015-05-06')
      h1= pt1.hojas.create(:tiempoDef => '2 meses', :razondeser => 'porque si')
      h2= pt1.hojas.create(:tiempoDef => '1 dia', :razondeser => 'porque si')
      assert h1.valid?, "h1 no válida #{h1.errors.inspect}"
    end
end
