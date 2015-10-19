class Certificacion < ActiveRecord::Base
  belongs_to :recurso #Pertenece a Recurso
  
  validates :recurso, :presence => true  #Valida que se guarde en un Recurso
  validates :descripcion, uniqueness: { scope: :recurso, message: "Una descripción por recurso" } #Valida que descripción sea atributo único para un Recurso
  validates :descripcion, presence: true #Valida que esos atributos no sean nulos
end
