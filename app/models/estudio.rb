class Estudio < ActiveRecord::Base
  has_many :tipos
  
  validates_numericality_of :precio
  validate :price_must_be_at_least_a_cent 
  
  def self.find_all
    find(:all).collect { |p| [p.tipo_estudio, p.id] }
  end
  
  def self.find_current
    find(:all,:conditions =>['id <= 3']).collect { |p| [p.tipo_estudio, p.id] }
  end
  
  def precio_formato
    helpers.number_to_currency(self.precio)
  end
  
  def descuento_porcentaje
    helpers.number_to_percentage(self.descuento*100,:precision => 0)
  end  
  
  def helpers
    ActionController::Base.helpers
  end
  
  protected 
  def price_must_be_at_least_a_cent 
    errors.add(:precio, 'debe ser al menos 0.01') if precio.nil? || 
    precio < 0.01 
  end 
  
  
end
