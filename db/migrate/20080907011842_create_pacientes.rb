class CreatePacientes < ActiveRecord::Migration
  def self.up
    create_table :pacientes do |t|
      t.string :nombre
      t.string :nombre_2
      t.string :app_pat
      t.string :app_mat
      t.string :rfc
      t.string :calle_fis
      t.string :colonia_fis
      t.string :estado_fis
      t.integer :cp_fis
      t.string :calle_dom
      t.string :colonia_dom
      t.string :estado_dom
      t.integer :cp_dom
      t.string :celular
      t.string :casa
      t.string :oficina
      t.string :recados
      t.string :fax
      t.string :correo
      t.string :pagina_web
      t.date :fecha_nac
      t.string :genero

      t.timestamps
    end
  end

  def self.down
    drop_table :pacientes
  end
end
