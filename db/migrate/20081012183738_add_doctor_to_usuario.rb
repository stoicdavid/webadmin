class AddDoctorToUsuario < ActiveRecord::Migration
  def self.up
    add_column :usuarios, :doctor_id, :integer
  end

  def self.down
    drop_column :usuarios, :doctor_id
  end
end
