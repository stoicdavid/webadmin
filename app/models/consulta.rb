class Consulta < ActiveRecord::Base
  belongs_to :paciente
  belongs_to :doctor
  belongs_to :cita
  has_one :inter, :dependent  => :destroy
  
  #validates_presence_of :doctor_id, :message => "no se puede crear" 
  #validates_inclusion_of :doctor_id, :in => Doctor.find(:all).map { |doc| doc.id }

  validates_presence_of :estudio_id, :message => "no puede ser vacio" 
  validates_inclusion_of :estudio_id, :in=> Estudio.find_all.map {|d,v| v}
  
end
