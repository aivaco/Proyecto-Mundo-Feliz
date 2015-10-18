class Portafolio < ActiveRecord::Base
  belongs_to :cliente #Pertenece a Cliente
  has_many :hojas, dependent: :destroy #Tiene muchas Hojas, que se destruyen si Portafolio es destruido
  
  validates :cliente, :presence => true #Valida que se guarde en un Cliente
  validates :fechaCreac, presence: true #Valida que esos atributos no sean nulos
end
