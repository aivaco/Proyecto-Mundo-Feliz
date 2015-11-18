# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Para correr las semillas:
# bundle exec rake db:migrate:reset
# bundle exec rake db:migrate
# bundle exec rake db:seed

#Agrega usuarios de ejemplo
User.create(usuario: "juan@juan.com",
             password:              "12345678",
             password_confirmation: "12345678",
             activated: true,
             activated_at: Time.zone.now)
             
User.create(usuario: "maria@maria.com",
             password:              "12345678",
             password_confirmation: "12345678",
             activated: true,
             activated_at: Time.zone.now)

User.create(usuario: "sutano@sutano.com",
             password:              "12345678",
             password_confirmation: "12345678",
             activated: true,
             activated_at: Time.zone.now)
             
User.create(usuario: "momba@momba.com",
             password:              "12345678",
             password_confirmation: "12345678",
             activated: true,
             activated_at: Time.zone.now)
        
User.create(usuario: "yahir@yahir.com",
             password:              "12345678",
             password_confirmation: "12345678",
             activated: true,
             activated_at: Time.zone.now)             
#usuario de prueba
User.create(usuario: "example@mundofeliz.com",
             password:              "12345678",
             password_confirmation: "12345678",
             activated: true,
             activated_at: Time.zone.now)
#Crea a las primeros tres usuarios en la tabla de personas.             
Persona.create(idPersona: "12321321321",
              email: "juan@juan.com",
              tipoPersona: "f")
Persona.create(idPersona: "646465156",
              email: "maria@maria.com",
              tipoPersona: "f")
Persona.create(idPersona: "41651305",
              email: "sutano@sutano.com",
              tipoPersona: "f")
Persona.create(idPersona: "481189416",
              email: "momba@momba.com",
              tipoPersona: "f")
Persona.create(idPersona: "981161818",
              email: "yahir@yahir.com",
              tipoPersona: "f")
#Añade la información personal de cada usuario.              
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
Fisica.create(nombre: "Momba",
              apellido1: "Momba",
              apellido2: "Momba",
              sexo: "f",
              fechaNac: Date.new(1984,5,2),
              persona_id: 4)
Fisica.create(nombre: "Yahir",
              apellido1: "Rojas",
              apellido2: "Ruíz",
              sexo: "m",
              fechaNac: Date.new(1974,5,2),
              persona_id: 5)
              
#Crea  clientes              
Cliente.create(nombreEmp: "Vaina S.A",
                persona_id: 4)
Cliente.create(nombreEmp: "Cerca S.A",
                persona_id: 5)  
#Crea portafolios                
Portafolio.create(fechaCreac: 1995-8-12,
                    cliente_id: 1)
Portafolio.create(fechaCreac: 2000-10-12,
                    cliente_id: 2)
                
#Crea hojas
Hoja.create(tiempoDef: "1 año",
              razonDeSer: "Es necesario un software que administre los movimientos de caja de la empresa.",
              portafolio_id: 1)
Hoja.create(tiempoDef: "6 meses",
              razonDeSer: "Se necesita un sitio web que presente al cliente todas las fortalezas de la empresa.",
              portafolio_id: 2) 
Hoja.create(tiempoDef: "Aproximadamente son necesarios seis meses a partir del 15 de noviembre de 2015.",
              razonDeSer: "La empresa Vaina S.A presenta la necesidad de un software que maneje transacciones de caja - cliente. Para ello se ha decidido desarrollar un software de punto de venta que controle todo lo referente a la facturación y el flujo de caja, el inventario, la lista de clientes y la bitácora. Es necesario crear un software que presente todas las funciones comunes en este tipo de programas.",
              portafolio_id: 1) 
              
#Crea recursos
r1 = Recurso.create(almaMater: "UCR", 
               fisica_id: 1)
r2 = Recurso.create(almaMater: "UNA", 
               fisica_id: 2)
r3 = Recurso.create(almaMater: "TEC", 
               fisica_id: 3)
              
#Crea proyectos
pr1 = Proyecto.create(nombre: "Punto de venta",
                  presupuesto: 2500.698,
                  precio: 1000.00,
                  estado: "d",
                  hoja_id: 1)
pr2 = Proyecto.create(nombre: "Sitio Web",
                  presupuesto: 2500.698,
                  precio: 1000.00,
                  estado: "c",
                  hoja_id: 2)
pr3 = Proyecto.create(nombre: "Segundo Punto de Venta",
                  presupuesto: 2500.698,
                  precio: 1000.00,
                  estado: "p",
                  hoja_id: 3)
#Agrega personas a los proyectos
#Proyecto 1
pr1.rols.create(recurso: r1, papel: 'Scrum Master')
pr1.rols.create(recurso: r2, papel: 'Desarrollador')
#Proyecto 2
pr2.rols.create(recurso: r2, papel: 'Scrum Master')
pr2.rols.create(recurso: r1, papel: 'QA')
#Proyecto 3
pr2.rols.create(recurso: r3, papel: 'Scrum Master')

#Crea documento de riesgo
Riesgo.create(tipo: "Prueba",
                descripcion: "Algunos riesgos que podrían afectar el rendimiento son: el costo económico y los recursos limitados de hardware.",
                proyecto_id: 1)
Riesgo.create(tipo: "Prueba",
                descripcion: "Algunos riesgos que podrían afectar el rendimiento son: el costo económico y los recursos limitados de hardware.",
                proyecto_id: 2)
              


#Crea entregables
e1 = Entregable.create(numero: 1,
                  fechaEnt: Date.new(2015,12,5),
                  descripcion: "Módulo de inicio de sesión del programa",
                  proyecto_id: 1)

e2 = Entregable.create(numero: 2,
                  fechaEnt: Date.new(2015,12,5),
                  descripcion: "Implementación del menú del programa",
                  proyecto_id: 2)

e3 = Entregable.create(numero: 3,
                  fechaEnt: Date.new(2016,7,12),
                  descripcion: "Módulo de tipo de cambio",
                  proyecto_id: 3)
 
e4 = Entregable.create(numero: 4,
                  fechaEnt: Date.new(2016,7,12),
                  descripcion: "Implementación del módulo de caja",
                  proyecto_id: 1)
                  
e5 = Entregable.create(numero: 5,
                  fechaEnt: Date.new(2015,12,31),
                  descripcion: "Módulo de inicio de sesión del programa",
                  proyecto_id: 2)
#Añade recursos a entregables (crea activos)
#Proyecto 1
    e1.activos.create(recurso: r1, estado: true)
    e4.activos.create(recurso: r2, estado: true)
#Proyecto 2
    e2.activos.create(recurso: r2, estado: false)
    e5.activos.create(recurso: r1, estado: false)
#Proyecto 3
    e3.activos.create(recurso: r3, estado: false)


#Datos Ruiz. 
User.create(usuario: "pj045", password: "12345678")
Cliente.create(nombreEmp: "Cosa S.A", persona_id: 3) 
Direccion.create(tipo: "f", pais: "Costa Rica", provincia: "San Jose", ciudad: "Sabanilla", dirExac: "Frente al AMPM", persona_id: 1)
Direccion.create(tipo: "f", pais: "Costa Rica", provincia: "San Jose", ciudad: "Guadalupe", dirExac: "Costado norte de Novacentro", persona_id: 2)
Direccion.create(tipo: "f", pais: "Costa Rica", provincia: "San Jose", ciudad: "Montes de Oca", dirExac: "100m este de la iglesia", persona_id: 3)
Telefono.create(tipo: "casa", numero: 34586797, persona_id: 1)
Telefono.create(tipo: "celular", numero: 45656776, persona_id: 1)
Telefono.create(tipo: "oficina", numero: 90764534, persona_id: 1)
Telefono.create(tipo: "celular", numero: 22314134, persona_id: 2)
Telefono.create(tipo: "oficina", numero: 88714134, persona_id: 2)
Telefono.create(tipo: "oficina", numero: 54311234, persona_id: 3)
