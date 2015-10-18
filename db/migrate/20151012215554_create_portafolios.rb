class CreatePortafolios < ActiveRecord::Migration
  def change
    create_table :portafolios do |t|
      t.date :fechaCreac
      t.references :cliente, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
