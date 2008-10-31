class AddHorasOcupadasColumn < ActiveRecord::Migration
  def self.up
     add_column :horarios, :horas_ocupadas, :string
  end

  def self.down
    drop_colum :horarios, :horas_ocupadas
  end
end
