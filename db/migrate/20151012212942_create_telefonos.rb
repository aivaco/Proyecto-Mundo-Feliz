class CreateTelefonos < ActiveRecord::Migration
  def change
    create_table :telefonos do |t|
      t.string :tipo
      t.integer :numero
      t.references :persona, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
