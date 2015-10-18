require 'test_helper'

class ClienteTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
    test "Solo se crea Cliente si existe persona" do
     # p1 = Persona.create(:idpersona => '123', :email => 'lola@lolesca.com', :tipopersona => 'f')
      c1 = Cliente.create(:nombreEmp => 'Olakase')
      assert !c1.valid?, "c1 no válida #{c1.errors.inspect}"
    end
    
    test "nombreEmp no puede ser nulo" do
      p1 = Persona.create(:idpersona => '123', :email => 'lola@lolesca.com', :tipopersona => 'f')
      c1 = p1.create_cliente()
      assert !c1.valid?, "c1 no válida #{c1.errors.inspect}"
    end
end
