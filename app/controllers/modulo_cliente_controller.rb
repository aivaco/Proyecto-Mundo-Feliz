class ModuloClienteController < ApplicationController

  def modulo_cliente
  	#@cliente = Cliente.find(params[:id])
  	@cliente = {nombreEmp: "Ruby Code", ubicacion: "Guadalupe", contacto: "Ing. Adolfo", email: "jpabloruiz@gmail.com", telefono:"2511-8547"}
  	#@listaProyectos = Proyecto.find(@cliente.proyectos)
  	@listaProyectos = [{id: 0, nombre: "Proyecto Contabilidad", razon: "Contabilidad", tiempo: "6 meses", administrador: "Francisco C", costo: "$4000"}, {id: 1, nombre: "Proyecto Secreto", razon: "Facturacion", tiempo: "2 meses", administrador: "Juan Ruiz", costo: "$1000"}, {id: 2, nombre: "Proyecto 3 Impresion", razon: "Impresion de Facturas", tiempo: "2 semanas", administrador: "Carlos López C", costo: "$800"}]
    

    if params[:idProyecto]
      @proyecto = @listaProyectos[params[:idProyecto].to_i]
    else
      @proyecto = {id: "", nombre: "", razon: "", tiempo: "", administrador: "", costo: ""}
    end

  end

  def lista_clientes
    
    if params[:buscarCliente]
      @clienteABuscar = params[:buscarCliente][:cliente]
      @clientes = Cliente.where('name LIKE ?', "%#{@clienteABuscar}%")
    else
      @clientes = Cliente.all
    end

  end

  def actualizar_proyectos
  end

  def nuevo_cliente
  end

end
