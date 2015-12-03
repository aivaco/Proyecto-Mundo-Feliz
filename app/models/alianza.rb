class Alianza < ActiveRecord::Base
  belongs_to :proyecto #Pertenece a Proyecto
  
   validates :proyecto, :presence => true #Valida que se guarde en un Proyecto.
   validates :tipo, uniqueness: { scope: :proyecto, message: "Un tipo por proyecto" } #Valida que tipo sea atributo único para un Proyecto
   validates :tipo, :nombreEmp, :proposito, :fechaFin, presence: true #Valida que esos atributos no sean nulos
end
