pdf.bounding_box([200,720], :width=>200, :height=>100) do
  pdf.font.size = 10
  pdf.text "AMERICAN NEUROLAB INC."
end

pdf.bounding_box([20,650], :width=>200, :height=>100) do
  pdf.font.size = 10
  pdf.text 'Hora de Llegada:'
  pdf.text 'Hora de Conexión'
  pdf.text 'Fin de Conexión'
  pdf.text 'Inicio de Estudio'
  pdf.text 'Fin de Estudio'
end

pdf.bounding_box([400,650], :width=>200, :height=>100) do
  pdf.font.size = 10
  pdf.text Time.now.strftime('%A, %d de %B de %Y')
  pdf.text Time.now.strftime('%H:%M')
  pdf.text 'Estudio:'
end
pdf.text 'Nombre completo del paciente: (nombre,segundo nombre, apellido paterno y materno)'
pdf.text " "
pdf.text  @paciente.nombre_completo
pdf.text " "

pdf.text "Fecha de nacimiento: #{@paciente.fecha_nac.strftime('%d / %m / %Y')} (#{@paciente.edad} años #{@paciente.edad_meses}  meses)"
pdf.text " "
pdf.text 'Médico que lo envía: ' + @consulta.doctor.nombre_completo
pdf.text " "
pdf.text 'Diagnóstico: ' + @consulta.diagnostico
pdf.text " "
pdf.text 'Resumen del padecimiento:'
pdf.text  " "
pdf.text " "
pdf.text 'Medicación actual:'
pdf.text  " "
pdf.text 'Domicilio particular:'
pdf.text " "
pdf.text  @paciente.domicilio_completo
pdf.text " "
pdf.text 'Teléfonos del contacto:'
pdf.text " "
pdf.text 'Nombre del contacto'
pdf.text " "
pdf.text 'Celular (044)'
pdf.text " "
pdf.text 'e-mail '
pdf.text " "
pdf.text 'Tel. casa'
pdf.text " "
pdf.text 'Tel. oficina'
pdf.text " "
pdf.text 'Datos de Facturación:'
pdf.text 'Nombre o razón social:'
pdf.text 'Domicilio Fiscal:'
pdf.text 'RFC:'
pdf.text 'Forma de pago:'
pdf.text 'TDC DDA Cheque Efectivo'
pdf.text 'Nombre y Firma'


