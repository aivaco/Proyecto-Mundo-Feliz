class AddColumnToActivo < ActiveRecord::Migration
  def change
    add_column :activos, :entregable_id, :integer
    add_column :activos, :recurso_id, :integer
    add_column :activos, :estado, :boolean
  end
end
