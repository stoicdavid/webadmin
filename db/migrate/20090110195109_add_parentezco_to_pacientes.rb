class AddParentezcoToPacientes < ActiveRecord::Migration
  def self.up
    add_column :pacientes, :parentezco, :string
  end

  def self.down
    remove_column :pacientes, :parentezco
  end
end
