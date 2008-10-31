class CreatePagos < ActiveRecord::Migration
  def self.up
    create_table :pagos do |t|
      t.string :forma_pago
      t.boolean :factura
      t.integer :folio_factura
      t.decimal :total, :precision  => 8 , :scale => 2, :default => 0

      t.timestamps
    end
  end

  def self.down
    drop_table :pagos
  end
end
