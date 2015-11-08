# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.create(usuario: "example@mundofeliz.com",
             password:              "12345678",
             password_confirmation: "12345678",
             activated: true,
             activated_at: Time.zone.now)
             
Persona.create(idPersona: "12321321321",
              email: "juan@juan.com",
              tipoPersona: "f")
Persona.create(idPersona: "646465156",
              email: "maria@maria.com",
              tipoPersona: "f")
Persona.create(idPersona: "41651305",
              email: "sutano@sutano.com",
              tipoPersona: "f")
              
Fisica.create(nombre: "Juan",
              apellido1: "Pérez",
              apellido2: "Soto",
              sexo: "m",
              fechaNac: Date.new(2001,2,3),
              persona_id: 1)
Fisica.create(nombre: "Maria",
              apellido1: "Pérez",
              apellido2: "Soto",
              sexo: "f",
              fechaNac: Date.new(1992,2,3),
              persona_id: 2)
Fisica.create(nombre: "Sutano",
              apellido1: "Mengano",
              apellido2: "Soto",
              sexo: "m",
              fechaNac: Date.new(1964,5,2),
              persona_id: 3)
              
Cliente.create(nombreEmp: "Vaina S.A",
                persona_id: 1)
Cliente.create(nombreEmp: "Cerca S.A",
                persona_id: 2)  
                
Portafolio.create(fechaCreac: 1995-8-12,
                    cliente_id: 1)
Portafolio.create(fechaCreac: 2000-10-12,
                    cliente_id: 2)
                

Hoja.create(tiempoDef: "1 año",
              razonDeSer: "Es necesario un software que administre los movimientos de caja de la empresa.",
              portafolio_id: 1)
Hoja.create(tiempoDef: "6 meses",
              razonDeSer: "Se necesita un sitio web que presente al cliente todas las fortalezas de la empresa.",
              portafolio_id: 2) 
Hoja.create(tiempoDef: "Aproximadamente son necesarios seis meses a partir del 15 de noviembre de 2015.",
              razonDeSer: "La empresa Vaina S.A presenta la necesidad de un software que maneje transacciones de caja - cliente. Para ello se ha decidido desarrollar un software de punto de venta que controle todo lo referente a la facturación y el flujo de caja, el inventario, la lista de clientes y la bitácora. Es necesario crear un software que presente todas las funciones comunes en este tipo de programas.",
              portafolio_id: 1)    

Proyecto.create(nombre: "Punto de venta",
                  presupuesto: 2500.698,
                  precio: 1000.00,
                  estado: "d",
                  hoja_id: 1)
Proyecto.create(nombre: "Sitio Web",
                  presupuesto: 2500.698,
                  precio: 1000.00,
                  estado: "c",
                  hoja_id: 2)
Proyecto.create(nombre: "Segundo Punto de Venta",
                  presupuesto: 2500.698,
                  precio: 1000.00,
                  estado: "p",
                  hoja_id: 3)

Riesgo.create(tipo: "Prueba",
                descripcion: "Algunos riesgos que podrían afectar el rendimiento son: el costo económico y los recursos limitados de hardware.",
                proyecto_id: 1)
Riesgo.create(tipo: "Prueba",
                descripcion: "Algunos riesgos que podrían afectar el rendimiento son: el costo económico y los recursos limitados de hardware.",
                proyecto_id: 2)



99.times do |n|
  email = "example-#{n+1}@mundofeliz.com"
  password = "12345678"
  User.create!(usuario: email,
              password:              password,
              password_confirmation: password,
              activated: true,
              activated_at: Time.zone.now)
end