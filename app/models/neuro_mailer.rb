class NeuroMailer < ActionMailer::Base
  

  def registra_doctor(doctor,password)
    subject    'Gracias por registrarte en American Neurolab'
    recipients doctor.correo
    from       "info@americanneurolab.com"
    sent_on    Time.now
    body       :doctor => doctor,:password => password
  end

  def informa_paciente(paciente,estudio,cita,doctor)
    subject    "Indicaciones para #{estudio.tipo_estudio} de #{paciente.nombre_completo}"
    recipients paciente.correo
    from       "Rocío Valdez Dávalos <rvd@americanneurolab.com>"
    sent_on    Time.now
    content_type "text/html"
    body       :paciente => paciente,:estudio => estudio,:cita => cita,:doctor => doctor
    ruta = ""
    if paciente.edad(Time.now) < 3
      ruta = "#{RAILS_ROOT}/public/docs/instrucciones_previas_inf.pdf"
    elsif paciente.edad(Time.now) < 21
      ruta = "#{RAILS_ROOT}/public/docs/instrucciones_previas_teen.pdf"
    else
      ruta = "#{RAILS_ROOT}/public/docs/instrucciones_previas_adulto.pdf"
    end
    attachment :content_type  => "application/pdf",
               :body =>  File.read(ruta),
               :filename  =>  "instrucciones.pdf"

  end

end
