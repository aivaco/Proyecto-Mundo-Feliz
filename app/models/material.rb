class Material < ActiveRecord::Base
   belongs_to :proyecto #Pertenece a proyecto
  
   validates :proyecto, :presence => true #Valida que se guarde en un Proyecto.
   validates :tipo, uniqueness: { scope: :proyecto, message: "Un tipo por proyecto" } #Valida que tipo sea atributo único para un Proyecto
   validates :tipo, :descripcion, :uso, :fechafin, presence: true #Valida que esos atributos no sean nulos
end
