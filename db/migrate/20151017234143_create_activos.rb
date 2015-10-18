class CreateActivos < ActiveRecord::Migration
  def change
    create_table :activos do |t|

      t.timestamps null: false
    end
  end
end
