class NeuroMailer < ActionMailer::Base
  

  def registra_doctor(doctor,password)
    subject    'Gracias por registrarte en American Neurolab'
    recipients doctor.correo
    from       "stoicdavid@gmail.com"
    sent_on    Time.now
    body       :doctor => doctor,:password => password
  end

  def informa_paciente(paciente,estudio,cita)
    subject    "Indicaciones para #{estudio}"
    recipients paciente.correo
    from       "stoicdavid@gmail.com"
    sent_on    Time.now
    
    body       :paciente => paciente,:estudio => estudio,:cita => cita
  end

end
