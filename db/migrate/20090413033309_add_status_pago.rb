class AddStatusPago < ActiveRecord::Migration
  def self.up
    add_column :citas, :status_pago, :string
  end

  def self.down
    remove_column :citas, :status_pago
  end
end
