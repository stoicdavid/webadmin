class AddIndiceToSpecializations < ActiveRecord::Migration
  def self.up
     add_index :specializations, [:doctor_id, :especialidad_id]
    
  end

  def self.down
     remove_index :specializations, [:doctor_id, :especialidad_id]
  end
end
