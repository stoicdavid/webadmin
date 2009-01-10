class NeuroMailer < ActionMailer::Base
  

  def registra_doctor(doctor,password)
    subject    'Gracias por registrarte en American Neurolab'
    recipients doctor.correo
    from       "info@americanneurolab.com"
    sent_on    Time.now
    body       :doctor => doctor,:password => password
  end

  def informa_paciente(paciente,estudio,cita,doctor)
    subject    "Indicaciones para #{estudio.tipo_estudio}"
    recipients paciente.correo
    from       "info@americanneurolab.com"
    sent_on    Time.now
    
    body       :paciente => paciente,:estudio => estudio,:cita => cita,:doctor => doctor
  end

end
