class CreateInters < ActiveRecord::Migration
  def self.up
    create_table :inters do |t|
      t.text :principal
      t.text :activaciones
      t.text :conclusion

      t.timestamps
    end
  end

  def self.down
    drop_table :inters
  end
end
