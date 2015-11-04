class Persona < ActiveRecord::Base
    has_one :juridica, dependent: :destroy #Tiene una Jurídica, que se destruye si Persona es destruida
    has_one :fisica, dependent: :destroy, autosave: true #Tiene una Física, que se destruye si Persona es destruida
    has_many :direccions, dependent: :destroy #Tiene muchas Direccions, que se destruyen si Persona es destruida
    has_many :telefonos, dependent: :destroy  #Tiene muchos Teléfonod, que se destruyen si Persona es destruida
    has_one :cliente, dependent: :destroy  #Tiene un Cliente, que se destruye si Persona es destruida
    has_one :user, dependent: :destroy #Tiene un usuario, que se destruye si Persona es destruida
    
    #En user.rb:
    #belongs_to :persona #Pertenece a Persona
    #Para agregar la referencia:
    #rails g migration addPersonaToUser persona:references
    #Eso crea:
    #class AddPersonaToUser < ActiveRecord::Migration
    #   def change
    #        add_reference :users, :personas, index: true
    #   end
    #end
    #Luego: rake db:migrate
    
    ##Email CHECK
    email_regex = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
    
    validates_associated :fisica #Valida que se cumplan las validaciones de Física
    validates_associated :juridica #Valida que se cumplan las validaciones de Jurídica
    validates_associated :direccions #Valida que se cumplan las validaciones de Direccions
    validates_associated :telefonos #Valida que se cumplan las validaciones de Teléfonos
    validates_associated :cliente #Valida que se cumplan las validaciones de Cliente
    #validates_associated :user #Valida que se cumplen las validaciones de User
    
    accepts_nested_attributes_for :fisica
    
    validates :email , :format => {:with => email_regex}
    validates :idPersona, :email, :tipoPersona, presence: true #Valida que esos atributos no sean nulos
    validates :idPersona, uniqueness: true #Valida que idpersona sea único
    validates :tipoPersona, inclusion: { in: %w(f j), message: "%{value} no es un tipo válido de persona" }
end
