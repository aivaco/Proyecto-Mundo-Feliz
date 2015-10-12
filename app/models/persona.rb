class Persona < ActiveRecord::Base
    has_one :juridica, dependent: :destroy
    has_one :fisica, dependent: :destroy
    has_many :direccions, dependent: :destroy
    has_many :telefonos, dependent: :destroy
    has_one :cliente, dependent: :destroy
    
    validates :idpersona, :email, :tipopersona, presence: true
    validates :idpersona, uniqueness: true
    validates :tipopersona, inclusion: { in: %w(f j), message: "%{value} no es un tipo válido de persona" }
end
