require 'test_helper'

class CertificacionTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
  test 'varias certificaciones' do
    p2 = Persona.create(:idPersona => '456', :email => 'batman123@batmail.com', :tipoPersona => 'f')
    f2 = p2.create_fisica(:nombre => 'Bruce', :apellido1 => 'Wayne', :apellido2 => 'Nah', :sexo => 'm', :fechaNac => '1975-05-15')
    r1 = f2.create_recurso(almaMater: 'UCR')
    c1 = r1.certificacions.create(descripcion: 'Cisco Módulo 34224')
    c2 = r1.certificacions.create(descripcion: 'ola k ase')
    c3 = r1.certificacions.create(descripcion: 'lalalalala')
    h1 = r1.habilidads.create(descripcion: 'maestro pokemon')
    h2 = r1.habilidads.create(descripcion: 'maestro digimon')
    print r1.certificacions.each {}
  end
end
