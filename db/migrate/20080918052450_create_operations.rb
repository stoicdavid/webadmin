class CreateOperations < ActiveRecord::Migration
  def self.up
    create_table :operations do |t|
      t.string :ref_estudio
      t.integer :cita_id, :null => false, :options => 
      "CONSTRAINT fk_operations_citas REFERENCES citas(id)"   
      t.timestamp :hora_llegada
      t.timestamp :ini_conexion
      t.timestamp :fin_conexion
      t.timestamp :ini_estudio
      t.timestamp :fin_estudio
      t.date :fecha_interpretacion
      t.date :fecha_entrega
      

      t.timestamps
    end
  end

  def self.down
    drop_table :operations
  end
end
