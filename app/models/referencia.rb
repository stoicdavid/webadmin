class Referencia < ActiveRecord::Base

  validates_presence_of :estudio_id, :on => :create, :message => "no puede ser vacio"
  validates_inclusion_of :estudio_id, :in => Estudio.find_current.map { |disp,value| value }
  
  
end
