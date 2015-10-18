class CreateEntregables < ActiveRecord::Migration
  def change
    create_table :entregables do |t|
      t.integer :numero
      t.date :fechaEnt
      t.string :descripcion
      t.references :proyecto, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
