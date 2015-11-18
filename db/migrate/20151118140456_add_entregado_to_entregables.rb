class AddEntregadoToEntregables < ActiveRecord::Migration
  def change
    add_column :entregables, :entregado, :boolean,
    :default => false
  end
end
