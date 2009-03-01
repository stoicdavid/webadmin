class AddImagenToUsuarios < ActiveRecord::Migration
  def self.up
    add_column :usuarios, :imagen, :string
  end

  def self.down
    remove_column :usuarios, :imagen
  end
end
