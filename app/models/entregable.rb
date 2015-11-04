uclass Entregable < ActiveRecord::Base
  belongs_to :proyecto #Pertenece a Proyecto 
  has_many :activos #Tiene muchos activos
  has_many :recursos, through: :activos #Tiene muchos recursos a través de activos
  has_many :bitacoras #Tiene muchas bitácoras
  has_many :reporteros, through: :bitacoras, source: :recurso #Tiene muchos reporteros a través de activos
  
  validates :proyecto, :presence => true #Valida que se guarde en un Proyecto.
  validates :numero, uniqueness: { scope: :proyecto, message: "Un número por Proyecto" } #Valida que número sea atributo único para un Proyecto
  validates :numero, :fechaEnt, :descripcion, presence: true #Valida que esos atributos no sean nulos
end
