class CreateJuridicas < ActiveRecord::Migration
  def change
    create_table :juridicas do |t|
      t.string :razonsocial
      t.date :fechacreac
      t.references :persona, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
