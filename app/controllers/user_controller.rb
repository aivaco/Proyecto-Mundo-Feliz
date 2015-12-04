class UserController < ApplicationController
    
    def show
      @user = User.find(params[:id])
    end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = "Por favor ingrese a su correo electrónico para activar la cuenta."
      redirect_to root_url

=begin    if @user.save
      log_in @user                                          Esto estaba antes
      flash[:success] = "Welcome to the Sample App!"
=end      redirect_to @user
    else
      render 'new'
    end
  end

  private

    def user_params
      params.require(:user).permit(:usuario, :password,
                                   :password_confirmation)
    end
end
