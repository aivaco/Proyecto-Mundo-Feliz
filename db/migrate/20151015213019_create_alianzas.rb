class CreateAlianzas < ActiveRecord::Migration
  def change
    create_table :alianzas do |t|
      t.string :tipo
      t.string :nombreEmp
      t.string :proposito
      t.date :fechaFin
      t.references :proyecto, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
