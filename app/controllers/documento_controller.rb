class DocumentoController < ApplicationController
   #Incluye al helper para que pueda ser usado por el controlador.
    include DocumentoHelper
     
    def show
        @documento = Documento.find(params[:id])
        @id = params[:id_cliente]
    end

    

end
