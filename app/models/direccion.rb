class Direccion < ActiveRecord::Base
  belongs_to :persona #Pertenece a Persona
  
   validates :persona, :presence => true #Valida que se guarde en una Persona.
   validates :tipo, uniqueness: { scope: :persona, message: "Un tipo por persona" } #Valida que tipo sea atributo único para una Persona
   validates :tipo, :pais, :provincia, :ciudad, :dirExac, presence: true #Valida que esos atributos no sean nulos
end
