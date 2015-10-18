class AddColumnToBitacora < ActiveRecord::Migration
  def change
    add_column :bitacoras, :entregable_id, :integer
    add_column :bitacoras, :recurso_id, :integer
    add_column :bitacoras, :descripcion, :string
    add_column :bitacoras, :fecha, :date
  end
end
