class AccountActivationsController < ApplicationController
    def edit
        user = User.find_by(usuario: params[:email])
        if user && !user.activated? && user.authenticated?(:activation, params[:id])
          user.activate
          log_in user
          flash[:success] = "Cuenta activada!"
          redirect_to 'pages#home'
        else
          flash[:danger] = "Link de activación incorrecto"
          redirect_to root_url
        end
    end
end
