class CreateSearches < ActiveRecord::Migration
  def self.up
    create_table :searches do |t|
      t.string :nombre
      t.string :nombre_2
      t.string :ap_pat
      t.string :ap_mat

      t.timestamps
    end
  end

  def self.down
    drop_table :searches
  end
end
