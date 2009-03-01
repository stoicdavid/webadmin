class AddIdiomaToUsuario < ActiveRecord::Migration
  def self.up
    add_column :usuarios, :idioma, :string
    
  end

  def self.down
    remove_column :usuarios, :idioma
  end
end
