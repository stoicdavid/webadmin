class AddOtroToDoctors < ActiveRecord::Migration
  def self.up
    add_column :doctors, :genero, :string
  end

  def self.down
    remove_column :doctors, :genero
  end
end
