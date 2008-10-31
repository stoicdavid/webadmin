class CreateDoctors < ActiveRecord::Migration
  def self.up
    create_table :doctors do |t|
      t.string :nombre
      t.string :nombre_2
      t.string :app_pat
      t.string :app_mat
      t.string :calle
      t.string :colonia
      t.string :estado
      t.integer :cp
      t.string :telefono_consultorio
      t.string :celular
      t.string :correo
      t.string :fax

      t.timestamps
    end
  end

  def self.down
    drop_table :doctors
  end
end
