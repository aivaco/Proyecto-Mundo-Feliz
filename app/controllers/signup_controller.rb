class SignupController < ApplicationController
  
  def new
    
  end

  def create
    
    @persona=Persona.new(:idPersona=>params[:persona]["idPersona"], 
                                            :email=>params[:persona]["email"],
                                            :tipoPersona=>"f")
    if @persona.save!
      
      @fisica=Fisica.new(:nombre=>params[:persona]["nombre"],
                       :apellido1=>params[:persona]["apellido1"],
                       :apellido2=>params[:persona]["apellido2"],
                       :sexo=>params[:persona]["sexo"],
                       :fechaNac=>Date.new(params[:persona]["fechaNac(1i)"].to_i, params[:persona]["fechaNac(2i)"].to_i, params[:persona]["fechaNac(3i)"].to_i),
                       :persona=>@persona)
      if @fisica.save!
        
        @direccion=Direccion.new(:tipo=>"Principal",
                                 :pais=>params[:persona]["pais"],
                                 :provincia=>params[:persona]["provincia"],
                                 :ciudad=>params[:persona]["ciudad"],
                                 :dirExac=>params[:persona]["dirExac"],
                                 :persona=>@persona)
        if @direccion.save!
          
          @telefono=Telefono.new(:tipo=>"Principal",
                                 :numero=>params[:persona]["numero"],
                                 :persona=>@persona)
          if @telefono.save!
            
            @user=User.new(:usuario=>params[:persona]["email"],
                           :password=>params[:persona]["password"],
                           :persona=>@persona)
            if @user.save!
              
              UserMailer.account_activation(@user).deliver_now
              flash[:info] = "Porfavor revise su correo electrónico para activar la cuenta."
              redirect_to root_url
              return
              
            end
            
            flash.now[:danger] = 'Problemas guardando el usuario'
            render 'new'
            return
            
          end
          
          flash.now[:danger] = 'Problemas guardando el telefono'
          render 'new'
          return
          
        end
        
        flash.now[:danger] = 'Problemas guardando la direccion'
        render 'new'
        return
        
      end
      
      flash.now[:danger] = 'Problemas guardando los datos fisicos'
      render 'new'
      return
      
    end
    
    flash.now[:danger] = 'Problemas guardando la persona'
    render 'new'
    return
    
  end
  
end
