class Direccion < ActiveRecord::Base
  belongs_to :persona
  
   validates :tipo, uniqueness: { scope: :persona, message: "Un tipo por persona" }
   validates :tipo, :pais, :provincia, :ciudad, :direxac, presence: true
end
