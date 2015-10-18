class CreateHojas < ActiveRecord::Migration
  def change
    create_table :hojas do |t|
      t.string :tiempoDef
      t.string :razondeser
      t.references :portafolio, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
