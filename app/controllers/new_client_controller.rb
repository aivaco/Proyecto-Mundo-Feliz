class NewClientController < ApplicationController
  
  def new
    
  end

  def create
    
    @persona=Persona.new(:idPersona=>params[:persona]["idPersona"], 
                                            :email=>params[:persona]["email"],
                                            :tipoPersona=>"j")
    if @persona.save!
      
      @juridica=Juridica.new(:razonSocial=>params[:persona]["nombre"],
                       :fechaCreac=>Date.new(params[:persona]["fechaCreac(1i)"].to_i, params[:persona]["fechaCreac(2i)"].to_i, params[:persona]["fechaCreac(3i)"].to_i),
                       :persona=>@persona)
      if @juridica.save!
        
        @direccion=Direccion.new(:tipo=>"Principal",
                                 :pais=>params[:persona]["pais"],
                                 :provincia=>params[:persona]["provincia"],
                                 :ciudad=>params[:persona]["ciudad"],
                                 :dirExac=>params[:persona]["dirExac"],
                                 :persona=>@persona)
        if @direccion.save!
          
          flash[:info] = "Nuevo cliente guardado."
          redirect_to root_url
          return
          
        end
        
        flash.now[:danger] = 'Problemas guardando la direccion'
        render 'new'
        return
        
      end
      
      flash.now[:danger] = 'Problemas guardando los datos juridicos'
      render 'new'
      return
      
    end
    
    flash.now[:danger] = 'Problemas guardando la persona'
    render 'new'
    return
    
  end
  
end
