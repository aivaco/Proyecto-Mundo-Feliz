class CreateFisicas < ActiveRecord::Migration
  def change
    create_table :fisicas do |t|
      t.string :nombre
      t.string :apellido1
      t.string :apellido2
      t.string :sexo
      t.date :fechanac
      t.references :persona, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
