class ModuloEntregableController < ApplicationController
  def view_entregable
    if(params.has_key?(:entregable_numero)) then
      @entreg=Entregable.find(params[:entregable_numero].to_i)
    else
      @entreg=Entregable.first()
    end
  end
  
  #Actualiza una entrega con su descripción.
  def agregar_entrega
    puts params[:entregable][:entregable_id]  
    puts params[:entregable][:entrega] 
    id = params[:entregable][:entregable_id]
    entrega = params[:entregable][:entrega]
    if entrega.length <= 100 then
       flash[:danger] = "Imposible actualizar una entrega con su descripción tan corta. Debe contener 100 caracteres o más."
       redirect_to :back
    else
        @entregable = Entregable.find(id)
        @entregable.entrega = entrega
        @entregable.entregado = true
        @entregable.save
        flash[:success] = "Se realizó la entrega correctamente."
        redirect_to :back
    end
    
  end
  
end
