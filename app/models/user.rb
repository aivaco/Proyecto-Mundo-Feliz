class User < ActiveRecord::Base
  
  ##PICTURE
  has_attached_file :foto, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  do_not_validate_attachment_file_type :foto
  
  belongs_to :persona #Pertenece a Persona
  attr_accessor :remember_token, :activation_token, :reset_token
  before_save   :downcase_email
  before_create :create_activation_digest
  before_save { self.usuario = usuario.downcase }  
  
  validates :usuario, presence: true, length: { maximum: 50 }, uniqueness: true
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
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end
  
  #Olvida un usuario.
  def forget
    update_attribute(:remember_digest, nil)
  end
	  
#Para autenticarse con facebook.
def self.from_omniauth(auth)
  puts auth.info.name
  puts auth.info.last_name
  puts 'hola'
  existe = defined? auth.uid
  if existe
    if user = User.find_by_uid(auth.uid)
      return user
    else
      #Crea a la persona en la base de datos.
      persona = Persona.create(
      idPersona: "0000000000000", 
      email: auth.info.email,
      tipoPersona: "f"
       )
      #Crea al usuario en la base de datos.
      user = persona.create_user(
      provider: auth.provider,
      uid: auth.uid,
      usuario: auth.info.nickname  || auth.info.name,
      oauth_token:  auth.credentials.token,
      oauth_expires_at: Time.at(auth.credentials.expires_at),
      password: "Faceb00k!",
      password_confirmation: "Faceb00k!",
      activated: true,
      activated_at: Time.zone.now
      )

    return  user
    end
  end
end

  #Activa una cuenta.
  def activate
    update_attribute(:activated,    true)
    update_attribute(:activated_at, Time.zone.now)
  end
  #Envía el correo electrónico de activación de la cuenta.
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end
  #Coloca los atributos para reseteo de contraseña.
  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest,  User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end
  
  # Envía correo electrónico para reiniciar la contraseña.
  def send_password_reset_email
    #persona = Persona.find(self.id)
    UserMailer.password_reset(self).deliver_now
  end
  
  # Retorna true si la contraseña expiró.
  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end


private
  # Pasa el email a minúsculas.
    def downcase_email
      self.usuario = usuario.downcase
    end

    # Crea y asigna el nuevo token a través de un digest.
    def create_activation_digest
      self.activation_token  = User.new_token
      self.activation_digest = User.digest(activation_token)
    end
end





