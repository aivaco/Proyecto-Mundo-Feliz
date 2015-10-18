class CreateRecursos < ActiveRecord::Migration
  def change
    create_table :recursos do |t|
      t.string :almaMater
      t.references :fisica, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
