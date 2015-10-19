class ModuloClienteController < ApplicationController

  def modulo_cliente
  	#@cliente = Cliente.find(params[:id])
  	@cliente = {nombreEmp: "JP", ubicacion: "Guadalupe", contacto: "Ing. Ruiz", email: "jpabloruiz@gmail.com", telefono:"8870"}
  	#@listaProyectos = Proyecto.find(@cliente.proyectos)
  	@listaProyectos = [{nombre: "Proyecto 1"}, {nombre: "Proyecto 2"}, {nombre: "Proyecto 3"}, {nombre: "Proyecto 4"}, {nombre: "Proyecto 5"}]
  end

  def lista_clientes
  end

  def actualizar_proyectos
  end

  def nuevo_cliente
  	
  end
end
