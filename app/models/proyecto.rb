class Proyecto < ActiveRecord::Base
  belongs_to :hoja #Pertenece a Hoja
  before_save :crea_documento
  has_many :riesgos, dependent: :destroy #Tiene muchos Riesgos, que se destruyen si Proyecto es destruido
  has_many :materials, dependent: :destroy #Tiene muchos materials, que se destruyen si Proyecto es destruido
  has_many :alianzas, dependent: :destroy #Tiene muchas alianzas, que se destruyen si Proyecto es destruido
  has_many :entregables, dependent: :destroy #Tiene muchos entregables que se destruyen si Proyecto es destruido 
  has_many :rols #Tiene muchos rols
  has_many :recursos, through: :rols #Tiene muchos recursos a través de rols
  has_one :documento, dependent: :destroy
  
  #Trigger para crear un nuevo documento de markdown
  def crea_documento
    @Proyecto_a_guardar = self
    @hoja_a_guardar = Hoja.find(self.hoja_id)
    @nuevo_documento = Documento.create(titulo: self.nombre, razon: @hoja_a_guardar.razonDeSer, tiempo: @hoja_a_guardar.tiempoDef,
                                        precio: self.precio, costo: self.presupuesto, estado: self.estado,
                                        proyecto_id: @hoja_a_guardar.id)
  end
  
  validates_associated :riesgos #Valida que se cumplan las validaciones de Riesgos
  validates_associated :materials #Valida que se cumplan las validaciones de materials
  validates_associated :alianzas #Valida que se cumplan las validaciones de alianzas
  validates_associated :entregables #Valida que se cumplan las validaciones de entregables
  validates :hoja, :presence => true #Valida que se guarde en una Hoja.
  validates :nombre, :presupuesto, :precio, :estado, presence: true #Valida que esos atributos no sean nulos
  validates :estado, inclusion: { in: %w(d p t c), message: "%{value} no es un tipo válido de estado" } #Valida que estado sea solo d, p, t o c
end
