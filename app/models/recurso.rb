class Recurso < ActiveRecord::Base
  belongs_to :fisica #Pertenece a Física
  has_many :certificacions, dependent: :destroy #Tiene muchas Certificacions, que se destruyen si Recurso es destruido
  has_many :habilidads, dependent: :destroy #Tiene muchas Habilidads, que se destruyen si Recurso es destruido
  has_many :rols #Tiene muchos rols
  has_many :proyectos, through: :rols #Tiene muchos proyectos a través de rol
  has_many :activos #Tiene muchos activos
  has_many :entregables, through: :activos #Tiene muchos entregables a través de activos
  has_many :bitacoras #Tiene muchas bitácoras
  has_many :reportados, through: :bitacoras, source: :entregable #Tiene muchos reportados a través de activos
  
  validates_associated :certificacions #Valida que se cumplan las validaciones de Certificacions
  validates_associated :habilidads #Valida que se cumplan las validaciones de Habilidads
  validates :fisica, :presence => true  #Valida que se guarde en una Física
  validates :almaMater, presence: true #Valida que esos atributos no sean nulos
end
