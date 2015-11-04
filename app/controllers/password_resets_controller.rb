class PasswordResetsController < ApplicationController
  before_action :get_user,   only: [:edit, :update]
  before_action :valid_user, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]


  def new
  end

  def create
    #@persona = Persona.find_by(email: params[:password_reset][:email].downcase)
    #if @persona
    @user = User.find_by(usuario: params[:password_reset][:usuario].downcase)
    #end
    #@user = User.find_by(usuario: params[:password_reset])
    #[:email].downcase)
    if  @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = "El correo electrónico ha sido enviado."
      redirect_to root_url
    else
      flash.now[:danger] = "Dirección de correo electrónico no encontrada."
      render 'new'
    end
  end

  def edit
  end
  
  def update
    if params[:user][:password].empty?
      @user.errors.add(:password, "No puede estar vacio")
      render 'edit'
    elsif @user.update_attributes(user_params)
      log_in @user
      flash[:success] = "La contraseña ha sido cambiada."
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  #Retorna true si el password expiró.
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end
  
  private

    def persona_params
      params.require(:persona).permit(:email)
    end
    
    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end
    #Retorna un usuario según un nombre de usuario (email).
    def get_user
      @user = User.find_by(usuario: params[:usuario])
    end

    # Confirma un usuario válido.
    def valid_user
      unless (@user && @user.activated? &&
              @user.authenticated?(:reset, params[:id]))
        redirect_to root_url
      end
    end
    
    # Chequea vencimiento del token.
    def check_expiration
      if @user.password_reset_expired?
        flash[:danger] = "Imposible cambiar contraseña, expiró el tiempo de 2 horas."
        redirect_to new_password_reset_url
      end
    end
end