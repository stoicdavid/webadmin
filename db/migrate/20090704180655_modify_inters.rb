class ModifyInters < ActiveRecord::Migration
  def self.up
    add_column :inters, :size, :integer
    add_column :inters, :content_type, :string
    add_column :inters, :filename, :string
    add_column :inters, :operation_id, :integer
  end

  def self.down
    
  end
end
