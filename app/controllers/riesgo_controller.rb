class RiesgoController < ApplicationController
    
    #Recibe un id de documento de riesgo para desplegarlo.
     def show
        puts params[:rid]
        @riesgo = Riesgo.find(params[:rid])
    end
    
    
    #Crea un nuevo documento de riesgos
    def create
         @riesgo = Riesgo.new(riesgo_params)
         if @riesgo.save
             message  = "El documento se guardó con éxito."
             flash[:success] = message
             redirect_to :back
         else
            message  = "Imposible guardar el documento."
            flash[:danger] = message
            redirect_to :back
            
         end
    end
    #Borra un documento de riesgos según el tipo
    def delete
        puts params[:riesgo][:tipo]
        @riesgo_del = Riesgo.find_by(tipo: params[:riesgo][:tipo]).destroy
        flash[:success] = "El documento se eliminó correctamente."
        redirect_to :back
    end
    
    
    private
    #Parámetros fuertes(permite que estos parámetros sean vistos por el controlador)
        def riesgo_params
           params.require(:riesgo).permit(:tipo, :descripcion, :proyecto_id) 
        end
end
