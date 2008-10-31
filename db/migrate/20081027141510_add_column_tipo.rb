class AddColumnTipo < ActiveRecord::Migration
  def self.up
    add_column :consultas, :estudio_id, :integer
  end

  def self.down
    drop_column :consultas, :estudio_id
  end
end
