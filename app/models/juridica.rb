class Juridica < ActiveRecord::Base
  belongs_to :persona #Pertenece a Persona
  
  validates :persona, :presence => true #Valida que se guarde en una Persona. 
  validates :razonSocial, :fechaCreac, presence: true #Valida que esos atributos no sean nulos
end
