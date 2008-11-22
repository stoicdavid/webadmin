class AddFiscalToDoctors < ActiveRecord::Migration
  def self.up
    add_column :doctors, :rfc_virtual, :string
    add_column :doctors, :rfc_doc, :string
    add_column :doctors, :razon_doc, :string
    add_column :doctors, :calle_fis, :string
    add_column :doctors, :num_ext_fis, :string
    add_column :doctors, :num_int_fis, :string
    add_column :doctors, :colonia_fis, :string
    add_column :doctors, :del_mun_fis, :string
    add_column :doctors, :estado_fis, :string
    add_column :doctors, :cp_fis, :string
  end

  def self.down
    drop_column :doctors, :rfc_virtual
    drop_column :doctors, :rfc_doc
    drop_column :doctors, :razon_doc
    drop_column :doctors, :calle_fis
    drop_column :doctors, :num_ext_fis
    drop_column :doctors, :num_int_fis
    drop_column :doctors, :colonia_fis
    drop_column :doctors, :del_mun_fis
    drop_column :doctors, :estado_fis
    drop_column :doctors, :cp_fis
  end
end
