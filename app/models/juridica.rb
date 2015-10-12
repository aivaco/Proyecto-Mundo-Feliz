class Juridica < ActiveRecord::Base
  belongs_to :persona
  
   validates :razonsocial, :fechacreac, presence: true
end
