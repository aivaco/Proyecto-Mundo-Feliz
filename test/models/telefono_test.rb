require 'test_helper'

class TelefonoTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
   test "Solo se crea teléfono si existe persona" do
    p1 = Persona.create(:idpersona => '123', :email => 'lola@lolesca.com', :tipopersona => 'f')
    t1 = p1.telefonos.create(:tipo => 'casa', :numero => 11111)
    t2 = p1.telefonos.create(:tipo => 'ofi', :numero => 3333)
    assert t2.valid?, "t2 no válida #{t2.errors.inspect}"
    end
    
    test "Solo un tipo por persona" do
    p1 = Persona.create(:idpersona => '123', :email => 'lola@lolesca.com', :tipopersona => 'f')
    t1 = p1.telefonos.create(:tipo => 'casa', :numero => 11111)
    t2 = p1.telefonos.create(:tipo => 'casa', :numero => 3333)
    assert !t2.valid?, "t2 no válida #{t2.errors.inspect}"
    end
end
