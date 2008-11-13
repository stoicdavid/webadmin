class AddColumnContactoToPacientes < ActiveRecord::Migration
  def self.up
    add_column :pacientes, :nombre_contacto, :string
  end

  def self.down
    drop_column :pacientes, :nombre_contacto
  end
end
