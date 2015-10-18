class CreateHabilidads < ActiveRecord::Migration
  def change
    create_table :habilidads do |t|
      t.string :descripcion
      t.references :recurso, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
