class Cliente < ActiveRecord::Base
  belongs_to :persona #Pertenece a Persona
  has_one :portafolio, dependent: :destroy #Tiene un Portafolio, que se destruye si Cliente es destruído
  
  validates :persona, :presence => true #Valida que se guarde en una Persona
  validates :nombreEmp, presence: true #Valida que esos atributos no sean nulos
end
