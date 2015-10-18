class Fisica < ActiveRecord::Base
  belongs_to :persona #Pertenece a Persona
  has_one :recurso, dependent: :destroy #Tiene un Recurso, que se destruye si Fisica es destruida
  
  validates_associated :recurso #Valida que se cumplan las validaciones de Recurso
  validates :persona, :presence => true  #Valida que se guarde en una Persona
  validates :nombre, :apellido1, :sexo, :fechaNac, presence: true #Valida que esos atributos no sean nulos
  validates :sexo, inclusion: { in: %w(f m), message: "%{value} no es un tipo válido de sexo" } #Valida que sexo sea solo f o m
end
