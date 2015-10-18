class Rol < ActiveRecord::Base
   # attr_accessible :jedi_id, :padawan_id
    belongs_to :proyecto #Pertenece a Proyecto
    belongs_to :recurso #Pertenece a Recurso
end
