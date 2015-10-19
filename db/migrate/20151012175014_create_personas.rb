class CreatePersonas < ActiveRecord::Migration
  def change
    create_table :personas do |t|
      t.string :idpersona
      t.string :email
      t.string :tipopersona
      
      t.timestamps null: false
    end
  end
end
