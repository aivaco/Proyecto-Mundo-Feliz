class SessionsController < ApplicationController

  
  def new
  end
  
def create
    if user = User.from_omniauth(env["omniauth.auth"])
      session[:user_id] = user.id
      redirect_to root_url
    elsif  user = User.find_by(usuario: params[:session][:usuario].to_s.downcase) 
      if user && user.authenticate(params[:session][:password])
       #Autentica al usuario.
        log_in user
        redirect_to root_path
      else
        # Crea un mensaje de error.
        flash.now[:error] = 'Usuario y/o contraseña incorrectos.'
        render 'new'
      end
    end
end

  
  def destroy
    session[:user_id] = nil
    redirect_to "sessions#login"
  end
  
end
