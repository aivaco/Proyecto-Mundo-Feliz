class AddColumnToRol < ActiveRecord::Migration
  def change
    add_column :rols, :proyecto_id, :integer
    add_column :rols, :recurso_id, :integer
    add_column :rols, :papel, :string
  end
end
