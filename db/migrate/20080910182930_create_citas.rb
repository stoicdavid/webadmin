class CreateCitas < ActiveRecord::Migration
  def self.up
    create_table :citas do |t|
      t.integer :paciente_id, :null => false, :options => 
      "CONSTRAINT fk_citas_pacientes REFERENCES pacientes(id)"
      t.integer :operation_id, :null => false, :options => 
      "CONSTRAINT fk_citas_operations REFERENCES operations(id)"
      t.datetime :fecha_hora
      t.integer :cubiculo
      t.string :persona_conf
      t.boolean :confirma_doc
      t.boolean :confirma_valet
      t.string :acompana
      t.string :status

      t.timestamps
    end
  end

  def self.down
    drop_table :citas
  end
end
