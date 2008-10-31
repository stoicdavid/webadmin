class CreateHorarios < ActiveRecord::Migration
  def self.up
    create_table :horarios do |t|
      t.string :horas
      t.integer :cubiculo
      t.integer :cita_id

      t.timestamps
    end
  end

  def self.down
    drop_table :horarios
  end
end