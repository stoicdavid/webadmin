class Consulta < ActiveRecord::Base
  belongs_to :paciente
  belongs_to :doctor
  belongs_to :cita
  
  #validates_presence_of :doctor_id, :message => "no se puede crear" 
  #validates_inclusion_of :doctor_id, :in => Doctor.find(:all).map { |doc| doc.id }
  
end
