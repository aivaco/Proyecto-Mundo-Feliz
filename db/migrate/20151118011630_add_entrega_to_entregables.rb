class AddEntregaToEntregables < ActiveRecord::Migration
  def change
    add_column :entregables, :entrega, :string
  end
end
