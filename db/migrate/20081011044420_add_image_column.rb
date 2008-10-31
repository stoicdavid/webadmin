class AddImageColumn < ActiveRecord::Migration
  def self.up
    add_column :doctors, :imagen, :string
  end

  def self.down
    remove_column :doctors, :imagen
  end
end
