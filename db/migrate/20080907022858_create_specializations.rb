class CreateSpecializations < ActiveRecord::Migration
  def self.up
    create_table :specializations, :id => false do |t|
      t.integer :doctor_id, :null => false, :options =>
      "CONSTRAINT fk_specializations_doctors REFERENCES doctors(id)"
      t.integer :especialidad_id, :null => false, :options =>
      "CONSTRAINT fk_specializations_especialidads REFERENCES especialidads(id)"
      t.timestamps
    end
  end
   

  def self.down
    drop_table :doctor_especialidads
   
  end
end
