class CreateUsuarios < ActiveRecord::Migration
  def self.up
    add_column :usuarios, :login, :string, :limit => 40
    add_column :usuarios, :email, :string, :limit => 100
    add_column :usuarios, :remember_token, :string, :limit => 40
    add_column :usuarios, :remember_token_expires_at, :datetime

    change_column :usuarios, :nombre, :string,:default => '', :limit => 100
    rename_column :usuarios, :hashed_password, :crypted_password
    rename_column :usuarios, :nombre, :name
    add_index :usuarios, :login, :unique => true
  end

  def self.down
    remove_column :usuarios,:login
    remove_column :usuarios,:email
    remove_column :usuarios, :remember_token
    remove_column :usuarios, :remember_token_expires_at
  end
end
