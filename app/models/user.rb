class User < ActiveRecord::Base
    
    validates :usuario, presence: true, length: { maximum: 20 }, uniqueness: true
    has_secure_password
    validates :password, presence: true, length: { minimum: 8 }
    


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


