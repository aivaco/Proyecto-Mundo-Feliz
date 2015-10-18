require 'test_helper'

class PersonaTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  test "No existe idpersona" do
    persona = Persona.new
    assert_not persona.save, "Guardo persona sin idpersona"
  end
  
    test "idpersona repetido" do
    p1 = Persona.create(:idpersona => '123', :email => 'lola@lolesca.com', :tipopersona => 'f')
    assert p1.valid?, "p1 no válida #{p1.errors.inspect}"
    
    p2= Persona.create(:idpersona => p1.idpersona, :email => 'perro@perruno.com', :tipopersona => 'f')
    assert !p2.valid?
  end
  
   test "tipo persona diferente de f o j" do
    p1 = Persona.create(:idpersona => '123', :email => 'lola@lolesca.com', :tipopersona => 'maincra')
    assert !p1.valid?, "p1 no válida #{p1.errors.inspect}"
    
  end
  
end
