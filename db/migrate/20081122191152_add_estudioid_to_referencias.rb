class AddEstudioidToReferencias < ActiveRecord::Migration
  def self.up
    add_column :referencias, :estudio_id, :integer
  end

  def self.down
    drop_column :referencias, :estudio_id
  end
end
