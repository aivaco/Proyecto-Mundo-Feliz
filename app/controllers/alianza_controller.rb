class AlianzaController < ApplicationController
    #Crea un nuevo documento de Alianza
    def create
         @alianza = Alianza.new(alianza_params)
         #puts @alianza.fechaFin
         if @alianza.save
             message  = "El documento se guardó con éxito."
             flash[:success] = message
             redirect_to :back
         else
            message  = "Imposible guardar el documento."
            flash[:danger] = message
            redirect_to :back
            
         end
    end
    #Borra un documento de alianza según el tipo
    def delete
        @alianza_del = Alianza.find_by(tipo: params[:alianza][:tipo]).destroy
        
        flash[:success] = "El documento se eliminó correctamente."
        redirect_to :back
    end
    
    private
        #Parámetros fuertes(permite que estos parámetros sean vistos por el controlador)
        def alianza_params
           params.require(:alianza).permit(:tipo, :nombreEmp, :proposito,:fechaFin,:proyecto_id) 
        end

end
