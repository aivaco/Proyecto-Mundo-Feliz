class DocumentoController < ApplicationController
   #Incluye al helper para que pueda ser usado por el controlador.
    include DocumentoHelper
     
    def show
        @documento = Documento.find(params[:id])
        @id = params[:id_cliente]
    end
    
    def add_documento
        puts params[:id_proyecto]
       @id_proyecto = params[:id_proyecto] 
    end
    

end
