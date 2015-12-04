class ModuloClienteController < ApplicationController

  def modulo_cliente

  	#@cliente = Cliente.find(params[:id])
  	@cliente = {nombreEmp: "", ubicacion: "", contacto: "", email: "", telefono:""}
  	#@listaProyectos = Proyecto.find(@cliente.proyectos)
  	#@listaProyectos = [{id: 0, nombre: "Proyecto Contabilidad", razon: "Contabilidad", tiempo: "6 meses", administrador: "Francisco C", costo: "$4000"}, {id: 1, nombre: "Proyecto Secreto", razon: "Facturacion", tiempo: "2 meses", administrador: "Juan Ruiz", costo: "$1000"}, {id: 2, nombre: "Proyecto 3 Impresion", razon: "Impresion de Facturas", tiempo: "2 semanas", administrador: "Carlos López C", costo: "$800"}]

    #cargar el cliente buscado en la lista de clientes
    if params[:idCliente]
      cliente = Cliente.find_by(id: params[:idCliente])
      persona = Persona.find_by(id: cliente[:persona_id])
      direccion = Direccion.find_by(persona_id: cliente[:persona_id])
      telefono = Telefono.find_by(persona_id: cliente[:persona_id])
      
      if persona[:tipoPersona] = 'f'
        fisica = Fisica.find_by(persona_id: cliente[:persona_id])
         @cliente = {id: cliente[:id], nombreEmp: cliente[:nombreEmp], ubicacion: direccion[:pais]+", "+direccion[:provincia]+", "+direccion[:ciudad], contacto: fisica[:nombre], email: persona[:email], telefono: telefono[:numero]}
      else
        juridica = Juridica.find_by(persona_id: cliente[:persona_id])
         @cliente = {id: cliente[:id], nombreEmp: cliente[:nombreEmp], ubicacion: direccion[:pais]+", "+direccion[:provincia]+", "+direccion[:ciudad], contacto: juridica[:razonSocial], email: persona[:email], telefono: telefono[:numero]}
     end
      #telefono = telefonos[1]
     
      
      portafolio = Portafolio.find_by(cliente_id: params[:idCliente])
      hoja = Hoja.find_by(portafolio_id: portafolio[:id])
      proyectos = Proyecto.where(hoja_id: hoja[:id])
      @listaProyectos = []
      proyectos.each do |proyecto|

        puts ({id: proyecto[:id], nombre: proyecto[:nombre], razon: hoja[:razonDeSer], tiempo: hoja[:tiepoDef], costo: proyecto[:precio]}).to_s
        @listaProyectos.push({id: proyecto[:id], nombre: proyecto[:nombre], razon: hoja[:razonDeSer], tiempo: hoja[:tiempoDef], costo: proyecto[:precio]})

          #cargar el proyecto en la tabla 
          if params[:idProyecto]
            if params[:idProyecto] == proyecto[:id].to_s
              @proyecto = {id: proyecto[:id], nombre: proyecto[:nombre], razon: hoja[:razonDeSer], tiempo: hoja[:tiempoDef], costo: proyecto[:precio]}
            end
          end
        end
      end

      if !@proyecto 
        @proyecto = {id: "", nombre: "", razon: "", tiempo: "", administrador: "", costo: ""}
      end

      if !@listaProyectos 
        @listaProyectos = []
      end

      clientesABuscar = [{nombreEmp: "Coding", ubicacion: "Guadalupe", contacto: "Ing. Francisco", email: "otro@gmail.com", telefono:"2511-8547"},{nombreEmp: "Ruby Code", ubicacion: "Guadalupe", contacto: "Ing. Adolfo", email: "jpabloruiz@gmail.com", telefono:"2511-8547"}]

      respond_to do |format|
        format.html
        format.json { 
          clientesABuscar.each do |cliente| 
           puts params[:term]
         end
         @clientes =  {nombreEmp: "Ruby Code", ubicacion: "Guadalupe", contacto: "Ing. Adolfo", email: "jpabloruiz@gmail.com", telefono:"2511-8547"}
       }
     end
   end

   def lista_clientes

  #comprobar primero si viene directamente de una busqueda
  if params[:buscarCliente]
    @clienteABuscar = params[:buscarCliente][:cliente].to_s
    #puts "Cliente a buscar : " + @clienteABuscar
    listaDeClientes = Cliente.where("nombreEmp LIKE ?", "%#{@clienteABuscar}%")
    puts listaDeClientes
  else
    listaDeClientes = Cliente.all

  end

  @clientes = []
  listaDeClientes.each do |cliente|
    persona = Persona.find_by(id: cliente[:persona_id])
    direccion = Direccion.find_by(persona_id: cliente[:persona_id])
    telefono = Telefono.find_by(persona_id: cliente[:persona_id])
    
     if persona[:tipoPersona] = 'f'
        fisica = Fisica.find_by(persona_id: cliente[:persona_id])
         @clientes.push({id: cliente[:id], nombreEmp: cliente[:nombreEmp], ubicacion: direccion[:pais]+", "+direccion[:provincia]+", "+direccion[:ciudad], contacto: fisica[:nombre], email: persona[:email], telefono: telefono[:numero]})
      else
        juridica = Juridica.find_by(persona_id: cliente[:persona_id])
         @clientes.push({id: cliente[:id], nombreEmp: cliente[:nombreEmp], ubicacion: direccion[:pais]+", "+direccion[:provincia]+", "+direccion[:ciudad], contacto: juridica[:razonSocial], email: persona[:email], telefono: telefono[:numero]})
     end
     
    #@clientes.push({id: cliente[:id], nombreEmp: cliente[:nombreEmp]], contacto: fisica[:nombre], correo: persona[:email], telefono: telefono[:numero]})
  end

  if params[:idCliente]
    @telefonos = ""
    cliente = Cliente.find_by(id: params[:idCliente])
    @nombreCliente = cliente.nombreEmp
    telefonoCliente = Telefono.where(persona_id: cliente[:persona_id])
    telefonoCliente.each do |telefono|
      puts "telefonoCliente" +  telefono.to_s
      @telefonos += telefono[:tipo] + " " + telefono[:numero].to_s + ", "
    end

    @telefonos = @telefonos[0, @telefonos.length - 2]

  end




end

def actualizar_proyectos
end

def nuevo_cliente
end

end
