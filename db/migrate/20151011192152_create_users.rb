class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :usuario
      t.string :password
      t.string :remember_session
      t.boolean :estado
      t.string :IdTipo
      t.string :IdPersona

      t.timestamps null: false
    end
  end
end
