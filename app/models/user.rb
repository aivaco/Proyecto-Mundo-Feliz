class User < ActiveRecord::Base
  
   attr_accessor :remember_token
    before_save { self.usuario = usuario.downcase }  
    validates :usuario, presence: true, length: { maximum: 20 }, uniqueness: true
    has_secure_password
    validates :password, presence: true, length: { minimum: 8 }, allow_nil: true
    
  # Devuelve una string encriptada por MD5.
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  
  #Retorna un token random.
  def User.new_token
    SecureRandom.urlsafe_base64
  end
    
  #Recuerda un usuario de la base de datos para usar en las sesiones persistentes (cookies). 
 def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end
  

  # Retorna true si el token es igual al digest del password en la base de datos.
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
  
  #Olvida un usuario.
  def forget
    update_attribute(:remember_digest, nil)
  end
  
#Para autenticarse con facebook.
def self.from_omniauth(auth)
  existe = defined? auth.uid
  if existe
  if user = User.find_by_uid(auth.uid)
    return user
  else
    user = User.create(
    provider: auth.provider,
    uid: auth.uid,
    usuario: auth.uid,
    oauth_token:  auth.credentials.token,
    oauth_expires_at: Time.at(auth.credentials.expires_at),
    password: "Faceb00k!",
    password_confirmation: "Faceb00k!"
    )
    return  user
end
end
end
end


