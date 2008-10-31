class CreateEstudios < ActiveRecord::Migration
  def self.up
    create_table :estudios do |t|
      t.string :tipo_estudio
      t.text :descripcion
      t.decimal :precio, :precision  => 8 , :scale => 2, :default => 0
      t.decimal :descuento, :precision  => 2 , :scale => 2, :default => 0
      t.timestamps
    end
  end

  def self.down
    drop_table :estudios
  end
end
