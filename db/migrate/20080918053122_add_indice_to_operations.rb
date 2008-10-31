class AddIndiceToOperations < ActiveRecord::Migration
  def self.up
    add_index :operations, [:cita_id]
  end

  def self.down
    remove_index :operations, [:cita_id]
  end
end
