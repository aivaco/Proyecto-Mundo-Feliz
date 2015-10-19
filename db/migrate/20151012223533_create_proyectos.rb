class CreateProyectos < ActiveRecord::Migration
  def change
    create_table :proyectos do |t|
      t.string :nombre
      t.float :presupuesto
      t.float :precio
      t.string :estado
      t.references :hoja, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
