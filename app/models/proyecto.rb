class Proyecto < ActiveRecord::Base
  belongs_to :hoja
  
  validates :nombre, :presupuesto, :precio, :estado, presence: true
  validates :estado, inclusion: { in: %w(d p t c), message: "%{value} no es un tipo válido de estado" }
end
