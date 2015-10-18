class Hoja < ActiveRecord::Base
  belongs_to :portafolio #Pertenece a Portafolio
  has_one :proyecto, dependent: :destroy #Tiene un Proyecto, que se destruye si Hoja es destruida
  
  validates :portafolio, :presence => true #Valida que se guarde en un Portafolio.
  validates :tiempoDef, :razondeser, presence: true #Valida que esos atributos no sean nulos
end
