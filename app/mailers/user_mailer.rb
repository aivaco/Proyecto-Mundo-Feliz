class UserMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.account_activation.subject
  #
  def account_activation(user) 
    #Hay que cambiarlo
    @user = user
    #mail to: user.email, subject: "Activación de cuenta"
    mail to: user.usuario, subject: "Activación de cuenta"
  end

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.password_reset.subject
  #
  def password_reset(user) 
    @user = user
    mail to: user.usuario, subject: "Reinicio de contraseña"

  end
end
