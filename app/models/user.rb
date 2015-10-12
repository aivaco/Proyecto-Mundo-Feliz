class User < ActiveRecord::Base
    
    validates :usuario, presence: true, length: { maximum: 20 }, uniqueness: true
    has_secure_password
    validates :password, presence: true, length: { minimum: 8 }
    #has_secure_password
=begin 
  attr_accessible :user_id, :password, :password_confirmation
  
  attr_accessor :password
  before_save :encrypt_password
  
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create
  validates_presence_of :user_id
  validates_uniqueness_of :user_id
  
  def self.authenticate(user_id, password)
    user = find_by_user_id(user_id)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
    end
  end
  
  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end
=end
end

