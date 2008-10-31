class AddIndiceToGenerates < ActiveRecord::Migration
  def self.up
    add_index :generates, [:operation_id, :pago_id]
  end

  def self.down
    remove_index :generates, [:operation_id, :pago_id]    
  end
end
