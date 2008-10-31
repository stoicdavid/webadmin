class AddColumnToPacientes < ActiveRecord::Migration
  def self.up
    add_column :pacientes, :razon, :string
    add_column :pacientes, :del_mun, :string
  end

  def self.down
    drop_colum :pacientes, :razon
    drop_colum :pacientes, :del_mun
  end
end
