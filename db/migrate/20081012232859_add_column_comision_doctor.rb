class AddColumnComisionDoctor < ActiveRecord::Migration
  def self.up
    add_column :estudios, :comision_doctor, :decimal,  :precision  => 8 , :scale => 2, :default => 0
    add_column :estudios, :comision_isr, :decimal,  :precision  => 8 , :scale => 2, :default => 0
  end

  def self.down
    drop_column :estudios, :comision_doctor
    drop_column :estudios, :comision_isr
  end
end
