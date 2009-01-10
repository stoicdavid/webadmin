require 'digest/sha1' 

class Usuario < ActiveRecord::Base
  belongs_to :doctor

  validates_presence_of :nombre
  validates_uniqueness_of :nombre

  attr_accessor :password_confirmation
  validates_confirmation_of :password
  validate :password_non_blank

  def password 
    @password 
  end

  def password=(pwd) 
    @password = pwd 
    return if pwd.blank? 
    create_new_salt 
    self.hashed_password = Usuario.encrypted_password(self.password, self.salt) 
  end

  def self.authenticate(nombre, password) 
    usuario = self.find_by_nombre(nombre)  
    if usuario 
      expected_password = encrypted_password(password, usuario.salt) 
      if usuario.hashed_password != expected_password 
        usuario = nil 
      end 
    end 
    usuario
  end

  private
  def password_non_blank
    errors.add_to_base("Falta el password") if hashed_password.blank?
  end
  

  def self.encrypted_password(password, salt) 
    string_to_hash = password + "wibble" + salt 
    Digest::SHA1.hexdigest(string_to_hash) 
  end 

  def create_new_salt 
    self.salt = self.object_id.to_s + rand.to_s 
  end 


end
