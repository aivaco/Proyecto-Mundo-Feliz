class ChangeColumnName < ActiveRecord::Migration
  def change
    rename_column :personas, :idpersona, :idPersona
    rename_column :personas, :tipopersona, :tipoPersona
    rename_column :juridicas, :razonsocial, :razonSocial
    rename_column :juridicas, :fechacreac, :fechaCreac
    rename_column :fisicas, :fechanac, :fechaNac
    rename_column :direccions, :direxac, :dirExac
    rename_column :hojas, :razondeser, :razonDeSer
  end
end
