class CreateDireccions < ActiveRecord::Migration
  def change
    create_table :direccions do |t|
      t.string :tipo
      t.string :pais
      t.string :provincia
      t.string :ciudad
      t.string :direxac
      t.references :persona, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
