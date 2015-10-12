class Telefono < ActiveRecord::Base
  belongs_to :persona
  
  validates :tipo, uniqueness: { scope: :persona, message: "Un tipo por persona" }
  validates :tipo, :numero, presence: true
  
end
