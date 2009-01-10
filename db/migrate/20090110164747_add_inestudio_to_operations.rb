class AddInestudioToOperations < ActiveRecord::Migration
  def self.up
    add_column :operations, :indice_estudio, :integer
  end

  def self.down
    remove_column :operations, :indice_estudio
  end
end
