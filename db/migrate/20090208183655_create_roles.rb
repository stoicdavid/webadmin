class CreateRoles < ActiveRecord::Migration
  def self.up
    create_table "roles" do |t|
      t.string :name
    end
    
    # generate the join table
    create_table "roles_usuarios", :id => false do |t|
      t.integer "role_id", "usuario_id"
    end
    add_index "roles_usuarios", "role_id"
    add_index "roles_usuarios", "usuario_id"
  end

  def self.down
    drop_table "roles"
    drop_table "roles_usuarios"
  end
end