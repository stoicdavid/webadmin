class AddDireccionToPaciente < ActiveRecord::Migration
  def self.up
    add_column :pacientes, :del_mun_dom, :string
    add_column :pacientes, :num_int_dom, :string
    add_column :pacientes, :num_ext_dom, :string
    add_column :pacientes, :num_int_fis, :string
    add_column :pacientes, :num_ext_fis, :string
  end

  def self.down
    drop_column :pacientes, :del_mun_dom
    drop_column :pacientes, :num_int_dom
    drop_column :pacientes, :num_ext_dom
    drop_column :pacientes, :num_int_fis
    drop_column :pacientes, :num_ext_fis
  end
end
