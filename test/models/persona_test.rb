require 'test_helper'

class PersonaTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  test "No existe idPersona" do
    persona = Persona.new
    assert_not persona.save, "Guardo persona sin idPersona"
  end
  
    test "idPersona repetido" do
    p1 = Persona.create(:idPersona => '123', :email => 'lola@lolesca.com', :tipoPersona => 'f')
    assert p1.valid?, "p1 no válida #{p1.errors.inspect}"
    
    p2= Persona.create(:idPersona => p1.idPersona, :email => 'perro@perruno.com', :tipoPersona => 'f')
    assert !p2.valid?
  end
  
   test "tipo persona diferente de f o j" do
    p1 = Persona.create(:idPersona => '123', :email => 'lola@lolesca.com', :tipoPersona => 'maincra')
    assert !p1.valid?, "p1 no válida #{p1.errors.inspect}"
    
  end
  
end
