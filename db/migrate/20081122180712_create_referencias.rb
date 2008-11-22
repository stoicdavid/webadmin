class CreateReferencias < ActiveRecord::Migration
  def self.up
    create_table :referencias do |t|
      t.string :nombre
      t.string :apellidos
      t.string :nombre_contacto
      t.string :diagnostico
      t.date :fecha_referencia
      t.string :telefono_casa
      t.string :telefono_celular
      t.string :e_mail
      t.integer :ref_id, :default => 0
      

      t.timestamps
    end
  end

  def self.down
    drop_table :referencias
  end
end
