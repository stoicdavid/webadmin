class CambiarTipoFechaSintomas < ActiveRecord::Migration
  def self.up
    change_column :consultas, :fecha_in_sintomas, :string
  end

  def self.down
    raise ActiveRecord::IrreversibleMigration 
  end
end
