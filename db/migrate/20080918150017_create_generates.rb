class CreateGenerates < ActiveRecord::Migration
  def self.up
    create_table :generates, :id => false do |t|
        t.integer :operation_id,  :options =>
        "CONSTRAINT fk_generates_operations REFERENCES operations(id)"
        t.integer :pago_id,  :options =>
        "CONSTRAINT fk_generates_pagos REFERENCES pagos(id)"
      t.timestamps
    end
  end

  def self.down
    drop_table :generates
  end
end
