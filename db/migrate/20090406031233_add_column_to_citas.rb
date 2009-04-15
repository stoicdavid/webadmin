class AddColumnToCitas < ActiveRecord::Migration
  def self.up
    add_column :citas, :state, :string
  end

  def self.down
    remove_column :citas, :state, :string
  end
end
