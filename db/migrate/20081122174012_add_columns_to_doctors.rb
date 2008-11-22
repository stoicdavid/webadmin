class AddColumnsToDoctors < ActiveRecord::Migration
  def self.up
    add_column :doctors, :especialidad_id, :integer
    add_column :doctors, :especialidad_otro, :string
  end

  def self.down
    drop_column :doctors, :especialidad_id
    drop_column :doctors, :especialidad_otro, :string
  end
end
