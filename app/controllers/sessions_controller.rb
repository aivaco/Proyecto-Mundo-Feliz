class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(usuario: params[:session][:usuario].to_s.downcase)
    if user && user.authenticate(params[:session][:password])
      # Autentica al usuario.
      log_in user
      redirect_to root_path

    else
      # Crea un mensaje de error.
      flash.now[:danger] = 'Usuario y/o contraseña incorrectos.'
      render 'new'
    end
  end
  
  def destroy
  end
end
