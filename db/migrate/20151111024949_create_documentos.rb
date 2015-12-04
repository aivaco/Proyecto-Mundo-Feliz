class CreateDocumentos < ActiveRecord::Migration
  def change
    create_table :documentos do |t|
      t.string :titulo
      t.string :razon
      t.string :tiempo
      t.float :precio
      t.float :costo
      t.string :estado
      t.integer :proyecto_id

      t.timestamps null: false
    end
  end
end
