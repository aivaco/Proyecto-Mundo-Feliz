class RecursosController < ApplicationController
  def lista_recursos
  	@recursos = []
  	@recursos.push({id: 1, nombreEmp: "Ruby Code" , ubicacion: "Guadalupe", contacto: "Ing. Adolfo", correo: "jpabloruiz@gmail.com", telefono:"2511-8547"})

  	#comprobar primero si viene directamente de una busqueda
  if params[:buscarRecurso]
    @recursoABuscar = params[:buscarRecursoc][:cliente].to_s
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
    fisica = Fisica.find_by(persona_id: recurso[:fisica_id])
    habilidades = Habilidad.where(recurso_id: recurso[:id])
    habilidadesString = ""
    habilidades.each do |habilidad|
    	habilidadesString += habilidad[:descripcion] + ", "
    end
    @recursos.push({codigo: recurso[:id].to_s, nombre: fisica[:nombre] +" "+ fisica[:apellido1], egresado: recurso[:almaMater], habilidades: habilidadesString, proyectos: ""})
  end

  if params[:idRecurso]
    
  end

  end

  def agregar_recurso
  end

  def opciones_recurso
  end
end
