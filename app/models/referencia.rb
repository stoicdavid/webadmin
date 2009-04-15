class Referencia < ActiveRecord::Base
  belongs_to :doctor
  has_one :paciente
  
  validates_presence_of :estudio_id, :on => :create, :message => "no puede ser vacio"
  validates_inclusion_of :estudio_id, :in => Estudio.find_current.map { |disp,value| value }
  
  accepts_nested_attributes_for :paciente, :allow_destroy => true
  
end
