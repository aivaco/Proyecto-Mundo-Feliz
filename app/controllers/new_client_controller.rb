class NewClientController < ApplicationController
  
  before_action :logged_in_user
  
  def logged_in_user
    unless logged_in?
      #flash[:danger] = "Antes de acceder a cualquier sección, por favor inicie sesión."
      redirect_to login_url
    end
  end
  
  def new
    
  end

  def create
    
    @persona=Persona.new(:idPersona=>params[:persona]["idPersona"], 
                                            :email=>params[:persona]["email"],
                                            :tipoPersona=>"j")
    if @persona.save!
      
      @juridica=Juridica.new(:razonSocial=>params[:persona]["razonSocial"],
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
