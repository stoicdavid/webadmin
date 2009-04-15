class AddColumnsReferenciasPacientes < ActiveRecord::Migration
  def self.up
    add_column :referencias, :ap_paterno, :string
    add_column :referencias, :ap_materno, :string
    add_column :referencias, :fecha_nac, :date
    add_column :referencias, :t_recados, :string
    add_column :referencias, :t_oficina, :string
    add_column :referencias, :t_fax, :string
    add_column :referencias, :email_2, :string
    add_column :pacientes, :correo_2, :string
  end

  def self.down
    remove_column :referencias, :ap_paterno
    remove_column :referencias, :ap_materno
    remove_column :referencias, :fecha_nac
    remove_column :referencias, :t_recados
    remove_column :referencias, :t_oficina
    remove_column :referencias, :t_fax
    remove_column :referencias, :email_2
    remove_column :pacientes, :correo_2 
    
  end
end
