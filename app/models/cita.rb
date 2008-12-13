class Cita < ActiveRecord::Base
  belongs_to :paciente
  has_one :operation,:dependent => :destroy 
  has_one :consulta
  has_one :horario
  
  validates_uniqueness_of :fecha_hora, :on => :update, :message => "ya existe con esa fecha"
  
  CUBICULO = [ 
  # Displayed stored in db 
  [ "1", 1 ], 
  [ "2", 2 ]
  ]
    
end
