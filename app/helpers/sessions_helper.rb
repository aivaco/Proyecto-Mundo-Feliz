module SessionsHelper
    #Permite guardar la cookie con la cuenta del usuario abierta (hasta que se cierre el navegador)
    def log_in(user)
        session[:user_id] = user.id
    end
    
    #Retorna el usuario logueado en un momento determinado
    def current_user
        @current_user ||= User.find_by(id: session[:user_id])
    end
    
    # Si el usuario está logueado retorna true.
    def logged_in?
        !current_user.nil?
    end
    
    #Elimina la sesión
    def log_out
        session.delete(:user_id)
    @current_user = nil
    end
end