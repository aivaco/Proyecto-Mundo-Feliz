class ModuloPortafolioController < ApplicationController
    def view_portafolio
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
  end
end
