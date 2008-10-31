class AddColumnToPagos < ActiveRecord::Migration
  def self.up
    add_column :pagos, :precio, :precision  => 8 , :scale => 2, :default => 0 
    add_column :pagos, :descuento, :precision  => 8 , :scale => 2, :default => 0 
  end
  
  def self.down
    drop_column :pagos, :precio
    drop_column :pagos, :descuento
  end
end
