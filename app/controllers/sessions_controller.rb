class SessionsController < ApplicationController

  
  def new
  end

  
def create
 
    if user = User.from_omniauth(env["omniauth.auth"])
      session[:user_id] = user.id
      redirect_to root_url
    elsif  user = User.find_by(usuario: params[:session][:usuario].to_s.downcase) 
      if user && user.authenticate(params[:session][:password])
        if user.activated?
            #Autentica al usuario.
            log_in user
            #Para guardar la cookie que recuerda al usuario.
            params[:session][:remember_me] == '1' ? remember(user) : forget(user)
            redirect_to root_path
        else
            message  = "La cuenta no ha sido activada."
            message += "Por favor revise el correo que se ha enviado a su cuenta."
            flash[:warning] = message
            redirect_to 'new'
        end
      else
        # Crea un mensaje de error.
        flash.now[:danger] = 'Usuario y/o contraseña incorrectos.'
        render 'new'
      end
     else
        # Crea un mensaje de error.
        flash.now[:danger] = 'Usuario y/o contraseña incorrectos.'
        render 'new'
    end
end

  
  def destroy
   log_out if logged_in?
   render 'new'
    #redirect_to 'sessions#login'
  end
  
  
end
