class CreateBitacoras < ActiveRecord::Migration
  def change
    create_table :bitacoras do |t|

      t.timestamps null: false
    end
  end
end
