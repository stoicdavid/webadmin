class AddColumnPagoIdToOperations < ActiveRecord::Migration
  def self.up
    add_column :operations, :pago_id, :integer
  end

  def self.down
    drop_column :operations, :pago_id
  end
end
