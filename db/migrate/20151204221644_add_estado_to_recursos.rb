class AddEstadoToRecursos < ActiveRecord::Migration
  def change
    add_column :recursos, :estado, :boolean, :default => true
  end
end
