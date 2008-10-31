class AddIndiceToTipos < ActiveRecord::Migration
  def self.up
    add_index :tipos, [:estudio_id, :operation_id]
  end

  def self.down
     remove_index :tipos, [:estudio_id, :operation_id]    
  end
end
