class Hoja < ActiveRecord::Base
  belongs_to :portafolio
  has_one :proyecto, dependent: :destroy
   validates :tiempoDef, :razonDeSer, presence: true
end
