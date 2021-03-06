class AddColumnToPagos < ActiveRecord::Migration
  def self.up
    add_column :pagos, :precio, :decimal, :precision  => 8 , :scale => 2, :default => 0 
    add_column :pagos, :descuento, :decimal, :precision  => 8 , :scale => 2, :default => 0 
  end
  
  def self.down
    drop_column :pagos, :precio
    drop_column :pagos, :descuento
  end
end
