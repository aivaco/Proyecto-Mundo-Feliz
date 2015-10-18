class Bitacora < ActiveRecord::Base
    belongs_to :entregable #Pertenece a Entregable
    belongs_to :recurso #Pertenece a Recurso
end
