class AddEstudioToPagos < ActiveRecord::Migration
  def self.up
    add_column :pagos, :operation_id, :integer
  end

  def self.down
    remove_column :pagos, :operation_id
  end
end
