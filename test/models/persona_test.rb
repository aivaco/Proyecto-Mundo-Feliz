require 'test_helper'

class PersonaTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  test "no debe guardar persona sin idpersona" do
    persona = Persona.new
    assert_not persona.save, "Guardo persona sin idpersona"
  end
end
