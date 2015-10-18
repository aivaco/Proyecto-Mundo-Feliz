require 'test_helper'

class PortafolioTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
    test "Solo se crea portafolio si existe persona y física" do
      p1 = Persona.create(:idPersona => '123', :email => 'lola@lolesca.com', :tipoPersona => 'f')
      f1 = p1.create_fisica(:nombre => 'fulano', :apellido1 => 'mengano', :apellido2 => 'nose', :sexo => 'm', :fechaNac => '1995-05-15')
      c1 = p1.create_cliente(:nombreEmp => 'Red Ribbon')
      pt1= c1.create_portafolio(:fechaCreac => '2015-05-06')
      assert pt1.valid?, "pt1 no válida #{pt1.errors.inspect}"
    end
    
      test "Busca cliente por id desde persona" do
        p1 = Persona.create(:idPersona => '123', :email => 'lola@lolesca.com', :tipoPersona => 'f')
        f1 = p1.create_fisica(:nombre => 'fulano', :apellido1 => 'mengano', :apellido2 => 'nose', :sexo => 'm', :fechaNac => '1995-05-15')
        c1 = p1.create_cliente(:nombreEmp => 'Red Ribbon')
        c2 = (Persona.find_by idPersona: '123').cliente
        #pt1= c2.create_portafolio(:fechaCreac => '2015-05-06')
        assert c2.valid?, "pt1 no válida #{c2.errors.inspect}"
    end
    
        test "Busca cliente por id desde cliente" do
          p1 = Persona.create(:idPersona => '123', :email => 'lola@lolesca.com', :tipoPersona => 'f')
          f1 = p1.create_fisica(:nombre => 'fulano', :apellido1 => 'mengano', :apellido2 => 'nose', :sexo => 'm', :fechaNac => '1995-05-15')
          c1 = p1.create_cliente(:nombreEmp => 'Red Ribbon')
          c2 = Cliente.joins(:persona).where('personas.idPersona' => '123').first #Join de cliente y persona, se usa first para obtener la instancia
          #pt1= c2.create_portafolio(:fechaCreac => '2015-05-06')
          assert c2.valid?, "pt1 no válida #{c2.errors.inspect}"
    end
end
