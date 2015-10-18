require 'test_helper'

class BitacoraTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  test 'funciona' do
    p1 = Persona.create(:idpersona => '123', :email => 'lola@lolesca.com', :tipopersona => 'f')
    f1 = p1.create_fisica(:nombre => 'fulano', :apellido1 => 'mengano', :apellido2 => 'nose', :sexo => 'm', :fechanac => '1995-05-15')
    c1 = p1.create_cliente(:nombreEmp => 'Red Ribbon')
    pt1= c1.create_portafolio(:fechaCreac => '2015-05-06')
    h1= pt1.hojas.create(:tiempoDef => '2 meses', :razondeser => 'porque si')
    h2= pt1.hojas.create(:tiempoDef => '1 dia', :razondeser => 'porque si')
    pr1= h1.create_proyecto(:nombre => 'Netflix Azul', :presupuesto => 432000, :precio => 1000000, :estado => 'd')
    e1= pr1.entregables.create(numero: 1, fechaEnt: '2016-01-01', descripcion: 'cierre de caja')
    e2= pr1.entregables.create(numero: 2, fechaEnt: '2016-03-01', descripcion: 'login')
    p2 = Persona.create(:idpersona => '456', :email => 'batman123@batmail.com', :tipopersona => 'f')
    f2 = p2.create_fisica(:nombre => 'Bruce', :apellido1 => 'Wayne', :apellido2 => 'Nah', :sexo => 'm', :fechanac => '1975-05-15')
    r1 = f2.create_recurso(almaMater: 'UCR')
    
    p3 = Persona.create(:idpersona => '456', :email => 'no tengo T.T', :tipopersona => 'f')
    f3 = p3.create_fisica(:nombre => 'Alana', :apellido1 => 'Días', :apellido2 => 'Martínez', :sexo => 'f', :fechanac => '1986-05-15')
    r2 = f3.create_recurso(almaMater: 'UNA')
    
    pr1.rols.create(recurso: r1, papel: 'Scrum Master')
    pr1.rols.create(recurso: r2, papel: 'Desarrollador')
    
    e1.activos.create(recurso: r1, estado: true)
    r1.activos.create(entregable: e2, estado: true)
    r1.bitacoras.create(entregable: e1, descripcion: 'Nada sirve u.u', fecha: '23-05-2015')
    r1.bitacoras.create(entregable: e1, descripcion: 'Lo mismo D:', fecha: '24-05-2015')
    print r1.reportados.each {}
    assert pr1.valid?, "pr1 no válido #{pr1.errors.inspect}"
  end
end
