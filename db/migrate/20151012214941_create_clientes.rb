class CreateClientes < ActiveRecord::Migration
  def change
    create_table :clientes do |t|
      t.string :nombreEmp
      t.references :persona, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
