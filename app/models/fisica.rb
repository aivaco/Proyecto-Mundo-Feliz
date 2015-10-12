class Fisica < ActiveRecord::Base
  belongs_to :persona
  
  validates :nombre, :apellido1, :apellido2, :sexo, :fechanac, presence: true
  validates :sexo, inclusion: { in: %w(f m), message: "%{value} no es un tipo válido de sexo" }
end
