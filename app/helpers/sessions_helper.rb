module SessionsHelper
    #Permite guardar la cookie con la cuenta del usuario abierta (hasta que se cierre el navegador)
    def log_in(user)
        session[:user_id] = user.id
    end
    #Recuerda a un usuario que tiene la sesión guardada en una cookie.
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end
    
    #Retorna el usuario logueado según una cookie.
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
      user = User.find_by(id: user_id)
      if user && user.authenticated?(cookies[:remember_token])
        log_in user
        @current_user = user
      end
    elsif
      @current_user = NIL
    end
  end
    
    # Si el usuario está logueado retorna true.
    def logged_in?
        !current_user.nil?
    end
    
      
  # Olvida un usuario de una sesión persistente (cookies).
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end
    
    #Elimina la sesión.
    def log_out
        forget(current_user)
        session.delete(:user_id)
        @current_user = nil
    end
    

    
    #Método para agregar un botón con ícono.
    def button_to_with_icon(path, text, button_class, icon)
      form_tag path, :method => :post do
      button_tag(:class => button_class) do
        concat content_tag(:i, nil, :class => icon.to_sym)
        concat text
        
      end
    end
  end
end