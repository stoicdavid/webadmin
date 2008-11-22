class AddColumnDoctorIdReferencias < ActiveRecord::Migration
  def self.up
    add_column :referencias, :doctor_id, :integer
  end

  def self.down
    drop_column :referencias, :doctor_id
  end
end
