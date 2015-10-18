class CreateRiesgos < ActiveRecord::Migration
  def change
    create_table :riesgos do |t|
      t.string :tipo
      t.string :descripcion
      t.references :proyecto, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
