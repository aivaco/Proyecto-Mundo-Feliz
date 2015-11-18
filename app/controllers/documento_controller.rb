class DocumentoController < ApplicationController
   #Incluye al helper para que pueda ser usado por el controlador.
    include DocumentoHelper
     
    def show
        @documento = Documento.find(params[:id])
        @id = params[:id_cliente]
    end
    
    def nuevoEntregable
        idProyecto= params[:agregarNuevoEntregable][:id].to_i
        descripcionEntregable = params[:agregarNuevoEntregable][:descripcion].to_s
        @proyecto = Proyecto.find(idProyecto)
        if @ultimoEntregable = Entregable.where("proyecto_id == :id", {id: @proyecto.id}).last
            numeroEntregable = @ultimoEntregable.numero
            @entregable = Entregable.new(:numero => numeroEntregable+1, :fechaEnt => Date.new(params[:range][:"start_date(1i)"].to_i,params[:range][:"start_date(2i)"].to_i,params[:range][:"start_date(3i)"].to_i), :descripcion => descripcionEntregable, :proyecto_id => idProyecto)
            if @entregable.save
                flash[:info] = "Nuevo entregable creado al proyecto actual."
                redirect_to :back
            else
               flash.now[:danger] = 'Ocurrió un eror.' 
               redirect_to :back
            end
        else
            @entregable = Entregable.new(:numero => 1, :fechaEnt => Date.new(params[:range][:"start_date(1i)"].to_i,params[:range][:"start_date(2i)"].to_i,params[:range][:"start_date(3i)"].to_i), :descripcion => descripcionEntregable, :proyecto_id => idProyecto)
            if @entregable.save
                flash[:info] = "Nuevo entregable creado al proyecto actual."
                redirect_to :back
            else
               flash.now[:danger] = 'Ocurrió un eror.' 
               redirect_to :back
            end   
        end
    end
    

end
