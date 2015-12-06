class RecursosController < ApplicationController
  def create_user
      usuario = User.create(:usuario => params[:crearUsuario][:usuario], :persona_id => params[:crearUsuario][:idPersona_row], :password => params[:crearUsuario][:contrasena], :password_confirmation => params[:crearUsuario][:contrasena], :activated => true, :activated_at =>  Time.zone.now)
      usuario.save()
      if usuario != nil
        @usuarioCreado = true
        @errorUsuario = false
      else
        @errorUsuario = true
      end 
      @usuarioCreado = false
      @errorUsuario = false
  
  end
  
  def lista_recursos

    if params[:idRecursoEliminar]
      #Habilidad.where(recurso_id: params[:idRecursoEliminar]).destroy_all
      #Recurso.find_by(id: params[:idRecursoEliminar]).destroy
      #bitacoras
      recurso = Recurso.find_by(id: params[:idRecursoEliminar])
      recurso.estado = false
      recurso.save()
    end

    #crea el recurso 
    
    if params[:crearUsuario]
      puts "hola"
      puts params[:crearUsuario]
      usuario = User.create(:usuario => params[:crearUsuario][:usuario], :persona_id => params[:crearUsuario][:idPersona_row], :password => params[:crearUsuario][:contrasena], :password_confirmation => params[:crearUsuario][:contrasena], :activated => true, :activated_at =>  Time.zone.now)
      puts usuario.usuario
      usuario.save()
      if usuario != nil
        @usuarioCreado = true
        @errorUsuario = false
      else
        @errorUsuario = true
      end 
    else
      @usuarioCreado = false
      @errorUsuario = false
    end 

    #crea el recurso 
    if params[:crearRecurso]

      puts params[:crearRecurso][:fechaDeNacimiento]

      persona = Persona.create(:idPersona=>params[:crearRecurso][:idPersona], :email => params[:crearRecurso][:correo],:tipoPersona=>"f")
      fecha = Date.new(params[:crearRecurso]["fechaDeNacimiento(1i)"].to_i, params[:crearRecurso]["fechaDeNacimiento(2i)"].to_i, params[:crearRecurso]["fechaDeNacimiento(3i)"].to_i)
      fisica = Fisica.create(:nombre=>params[:crearRecurso][:nombre],:apellido1=>params[:crearRecurso][:apellido1],:apellido2=>params[:crearRecurso][:apellido2], :sexo=>params[:crearRecurso][:sexo],:fechaNac=>fecha,:persona => persona)
      recurso = Recurso.create(:almaMater=> params[:crearRecurso][:almaMater], :fisica => fisica)
      habilidades = Habilidad.create(:descripcion=> params[:crearRecurso][:habilidades], :recurso=> recurso)
    end

    #editar el recurso, hacerle el update
    if params[:editarRecurso]
      recurso = Recurso.find_by(id: params[:editarRecurso][:idRecurso])
      fisica = Fisica.find_by(id: recurso[:fisica_id])
      persona = Persona.find_by(id: fisica[:persona_id])
      habilidad = Habilidad.find_by(recurso_id: recurso[:id])

      #update recurso
      recurso.almaMater = params[:editarRecurso][:almaMater]
      #update fisica
      fisica.nombre = params[:editarRecurso][:nombre]
      fisica.apellido1 = params[:editarRecurso][:apellido1]
      if params[:editarRecurso][:apellido2]
        fisica.apellido2 = params[:editarRecurso][:apellido2]
      end
      fisica.sexo = fisica.apellido2 = params[:editarRecurso][:sexo]
      fecha = Date.new(params[:editarRecurso]["fechaDeNacimiento(1i)"].to_i, params[:editarRecurso]["fechaDeNacimiento(2i)"].to_i, params[:editarRecurso]["fechaDeNacimiento(3i)"].to_i)
      fisica.fechaNac = fecha
      #update persona
      persona.idPersona = params[:editarRecurso][:idPersona]
      persona.email = params[:editarRecurso][:correo]
      #update habilidades
      habilidad.descripcion = params[:editarRecurso][:habilidades]
      #save
      recurso.save()
      fisica.save()
      persona.save()
      habilidad.save()
    end


    @recursos = []
    @recursos.push({id: 1, nombreEmp: "Ruby Code" , ubicacion: "Guadalupe", contacto: "Ing. Adolfo", correo: "jpabloruiz@gmail.com", telefono:"2511-8547"})

  	#comprobar primero si viene directamente de una busqueda
    if params[:buscarRecurso]
      @recursoABuscar = params[:buscarRecurso][:cliente].to_s
    #puts "Cliente a buscar : " + @clienteABuscar
    habilidades = Habilidad.where("descripcion LIKE ?", "%#{@recursoABuscar}%")
    listaDeRecursos = []
    habilidades.each do |habilidad|
      listaDeRecursos.push(Recurso.find_by(id: habilidad[:recurso_id]))
    end
    puts listaDeRecursos
  else
    listaDeRecursos = Recurso.all
  end

  @recursos = []
  listaDeRecursos.each do |recurso|
    if recurso.estado
      fisica = Fisica.find_by(id: recurso[:fisica_id])
      habilidades = Habilidad.where(recurso_id: recurso[:id])
      habilidadesString = ""
      habilidades.each do |habilidad|
    	  habilidadesString += habilidad[:descripcion] + " "
      end
      @recursos.push({codigo: recurso[:id].to_s, nombre: fisica[:nombre] +" "+ fisica[:apellido1], egresado: recurso[:almaMater], habilidades: habilidadesString, proyectos: ""})
    end
  end

  @opciones = false
  
  if params[:idRecursoOpciones]
    @opciones = true
    @idRecursoOp = params[:idRecursoOpciones]
    recurso = Recurso.find_by(id: @idRecursoOp)
    fisica = Fisica.find_by(id: recurso[:fisica_id])
    persona = Persona.find_by(id: fisica[:persona_id])
    fecha = fisica[:fechaNac]
    habilidades = Habilidad.find_by(recurso_id: recurso[:id])
    @recursoOp = {idRecurso: recurso[:id], nombre: fisica[:nombre], id: persona[:idPersona],  primerApellido: fisica[:apellido1],  segundoApellido: fisica[:apellido2], fechaDeNacimiento: fecha, sexo: fisica[:sexo], correo: persona[:email], almaMater: recurso[:almaMater], habilidades: habilidades[:descripcion]} 
  end

end

def agregar_recurso
end

def opciones_recurso
  if params[:idRecursoCrearUsuario]
    recurso = Recurso.find_by(id: params[:idRecursoCrearUsuario])
    fisica = Fisica.find_by(id: recurso[:fisica_id])
    persona = Persona.find_by(id: fisica[:persona_id])
    @idPersona = persona[:idPersona]
    @idPersona_row = persona[:id]
    @correoRecurso = persona[:email]
  end
  
end
end
