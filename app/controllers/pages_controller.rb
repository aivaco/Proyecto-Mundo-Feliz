class PagesController < ApplicationController
  
  #Redirecciona al login si usuario no está logueado  
  before_action :logged_in_user

    def logged_in_user
      unless logged_in?
        #flash[:danger] = "Antes de acceder a cualquier sección, por favor inicie sesión."
        redirect_to login_url
      end
    end

  
  # Controlador de la pagina con la vista principal
  def home
  end
  
  def mientras
  end

end
