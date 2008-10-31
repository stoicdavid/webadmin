class CreateConsultas < ActiveRecord::Migration
  def self.up
    create_table :consultas do |t|
      t.integer :paciente_id
      t.integer :doctor_id
      t.integer :cita_id
      t.datetime :fecha_envio
      t.datetime :fecha_consulta
      t.text :diagnostico
      t.date :fecha_in_sintomas
      t.text :medicina_anterior
      t.text :medicina_actual

      t.timestamps
    end
  end

  def self.down
    drop_table :consultas
  end
end
