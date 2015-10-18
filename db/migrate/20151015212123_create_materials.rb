class CreateMaterials < ActiveRecord::Migration
  def change
    create_table :materials do |t|
      t.string :tipo
      t.string :descripcion
      t.string :uso
      t.date :fechaFin
      t.references :proyecto, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
