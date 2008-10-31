class AddUsuario < ActiveRecord::Migration
  def self.up
    Usuario.create(:nombre  => 'admin',:password => '123', :password_confirmation  => '123' )
  end

  def self.down
  end
end
