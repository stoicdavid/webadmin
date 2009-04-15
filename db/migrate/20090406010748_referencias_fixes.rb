class ReferenciasFixes < ActiveRecord::Migration
  def self.up
    remove_column :referencias, :apellidos
  end

  def self.down
  end
end
