class BitacoraController < ApplicationController
	def bitacora_usuario

		@fechaYHora = Time.current.to_s
		@proyectosParaEntregables = []
		proyectos = Proyecto.all
		if proyectos
			proyectos.each do |proyecto|
				entregablesDelProyecto = Entregable.where(proyecto_id: proyecto[:id])
				entregablesDelProyecto.each do |entregable|
					@proyectosParaEntregables.push({id: proyecto[:id], nombre: proyecto[:nombre], estado: proyecto[:estado], entregable: entregable[:id], numeroEntregable: entregable[:numero]})
				end
			end
		end

		@idEntregable = false 

		if params[:idEntregable]
			@idEntregable = true
			entregable = Entregable.find_by(id: params[:idEntregable])
			proyecto = Proyecto.find_by(id: entregable[:proyecto_id])
			@proyecto = {nombreProyecto: proyecto[:nombre], estadoProyecto: proyecto[:estado], numeroEntregable: entregable[:numero], entregable: entregable[:id]}
		end

		if params[:enviarReporte]
			#if params[:enviarReporte][:idEntregable]
			reporte = params[:enviarReporte][:reporte].to_s
			contrasena = params[:enviarReporte][:contrasena].to_s
			@entregableCorrecto = true
			entregable = params[:enviarReporte][:entregable]
			time = Time.now

			user = User.find_by(id: current_user.id)
			if user.authenticate(contrasena)
				#user = User.find_by(id: 1)
				persona = Persona.find_by(id: user[:persona_id])
				fisica = Fisica.find_by(persona_id: persona[:id])
				recurso = Recurso.find_by(fisica_id: fisica[:id])

				Bitacora.create(:entregable_id => entregable, :recurso_id=> recurso[:id], :descripcion => reporte, :fecha => time.to_formatted_s(:number))

			else
				@entregableCorrecto = false
			end
			
			@entregableEnviado = true

		else
			@entregableEnviado = false
		end
		
	end

	def bitacora_administrador
		@bitacoras = []
		bitacorasLista = Bitacora.all
		if bitacorasLista
			bitacorasLista.each do |bitacora|
				recurso = Recurso.find_by(id: bitacora[:recurso_id])
				entregable = Entregable.find_by(id: bitacora[:entregable_id])
				proyecto = Proyecto.find_by(id: entregable[:proyecto_id])
				descripcionEntregable = entregable[:numero].to_s + " " + entregable[:descripcion]
				fisica = Fisica.find_by(id: recurso[:fisica_id])
				nombre = recurso[:id].to_s + " - " + fisica[:nombre] + " " + fisica[:apellido1]
				@bitacoras.push({proyecto: proyecto[:nombre] ,entregable: descripcionEntregable, recurso: nombre, descripcion: bitacora[:descripcion], fecha: bitacora[:fecha]})

			end
		end
		

	end

	def ver_bitacora 
		@bitacoras = []
		bitacorasLista = Bitacora.all
		if bitacorasLista
			bitacorasLista.each do |bitacora|
				recurso = Recurso.find_by(id: bitacora[:recurso_id])
				entregable = Entregable.find_by(id: bitacora[:entregable_id])
				proyecto = Proyecto.find_by(id: entregable[:proyecto_id])
				descripcionEntregable = entregable[:numero].to_s + " " + entregable[:descripcion]
				fisica = Fisica.find_by(id: recurso[:fisica_id])
				nombre = recurso[:id].to_s + " - " + fisica[:nombre] + " " + fisica[:apellido1]
				@bitacoras.push({proyecto: proyecto[:nombre] ,entregable: descripcionEntregable, recurso: nombre, descripcion: bitacora[:descripcion], fecha: bitacora[:fecha]})

			end
		end
	end

end
