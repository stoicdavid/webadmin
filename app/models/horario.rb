class Horario < ActiveRecord::Base
  belongs_to :cita
  
  def self.find_cubiculos
     find(:all).collect { |p| [p.cubiculo] }
   end
end
