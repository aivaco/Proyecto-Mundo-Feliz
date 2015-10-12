class Portafolio < ActiveRecord::Base
  belongs_to :cliente
  has_many :hojas, dependent: :destroy
  validates :fechaCreac, presence: true
end
