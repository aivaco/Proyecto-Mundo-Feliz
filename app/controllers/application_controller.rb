class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  
  include SimpleCaptcha::ControllerHelpers #simple captcha
  
  protect_from_forgery with: :exception
  private

  include SessionsHelper
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
 helper_method :current_user
 

  
end
