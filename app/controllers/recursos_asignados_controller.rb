class RecursosAsignadosController < ApplicationController
 
    def administrar
        
        @entregable = Entregable.find(params[:id])
       
        ### Recursos asignados al entregable
        @lista_recursos_asignados = []
        @recursos_entregable = @entregable.recursos.all
        @recursos_entregable.each do |recurso_asignado|
            # asocia el recurso con la persona fisica segun el ID 
            fisica = Fisica.find_by(persona_id: recurso_asignado.fisica_id ) 
            # Guarda los nombres de los recursos asignados al proyecto especificado 
            @lista_recursos_asignados.push(fisica) 
        end 
        
        ### Recursos no asignados al proyecto
        @lista_recursos_proyecto = [] 
        @proyecto = Proyecto.find(@entregable.proyecto_id)
        @recursos_proyecto = @proyecto.recursos.all 
        @recursos_proyecto.each do |recurso| 
            fisica = Fisica.find_by(persona_id: recurso.fisica_id )
            @lista_recursos_proyecto.push(fisica) 
        end 
        @lista_no_asignados = @lista_recursos_proyecto - @lista_recursos_asignados
        
        ### Para cargar los datos relacionados al entregable
         @hoja = Hoja.find(@proyecto.hoja_id)
         @id_portafolio = @hoja.portafolio_id
         @portafolio = Portafolio.find(@id_portafolio)
         @cliente = Cliente.find(@portafolio.cliente_id)
    end
    
    #Agrega el recurso seleccionado al entregable
    def agregarRecursoSeleccionado
        @fisica = Fisica.find(params[:id])
        @recurso = Recurso.find_by(fisica_id: @fisica.persona_id)
        @entregable = Entregable.find(params[:id_entregable])
        
        Activo.create( entregable_id: @entregable.id , recurso_id: @recurso.id , estado: true)
        redirect_to :back
    end
    
    #Quita el recurso seleccionado del entregable
    def removerRecursoSeleccionado
        @fisica = Fisica.find(params[:id])
        @recurso = Recurso.find_by(fisica_id: @fisica.persona_id)
        @entregable = Entregable.find(params[:id_entregable])
        
        id_activo = Activo.find_by_sql ["SELECT id FROM activos WHERE entregable_id = ? AND recurso_id = ?", @entregable.id, @recurso.id]
        
        Activo.delete( id_activo)
        
        redirect_to :back
    end    
    
end
