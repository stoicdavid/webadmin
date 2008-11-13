class AddRfcToPaciente < ActiveRecord::Migration
  def self.up
    add_column :pacientes, :rfc_pac, :string
  end

  def self.down
    drop_column :pacientes, :rfc_pac
  end
end
