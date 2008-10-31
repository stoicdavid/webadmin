class AddColumnToOperations < ActiveRecord::Migration
  def self.up
    add_column :operations, :tipo_id, :integer
  end

  def self.down
    drop_column :operations, :tipo_id
  end
end
