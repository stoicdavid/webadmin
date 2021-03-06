

pdf.bounding_box([20,650], :width=>200, :height=>100) do
  pdf.font.size = 10
  pdf.text 'Hora de Llegada:',:spacing => 6
  pdf.text 'Hora de Conexión:',:spacing => 6
  pdf.text 'Fin de Conexión:',:spacing => 6
  pdf.text 'Inicio de Estudio:',:spacing => 6
  pdf.text 'Fin de Estudio:'
  
	6.times do |i|
  			#pdf.fill_color "ff0000"					
			pdf.stroke_rectangle [90,100], 70, 15*i 
					
end
end
pdf.bounding_box([60,650], :width=>200, :height=>100) do
end

pdf.bounding_box([400,650], :width=>200, :height=>100) do
  pdf.font.size = 10
  pdf.text l @fecha_hora, :format => '%A, %d de %B de %Y'
  pdf.text @fecha_hora.strftime('%H:%M')
  pdf.text 'Estudio: ' + @ref_estudio.to_s
end
pdf.bounding_box([20,560], :width=>500, :height=>100) do
  pdf.font.size = 12
  pdf.text 'Nombre completo del paciente: (nombre,segundo nombre, apellido paterno y materno)',:size => 10
  pdf.text " "
  pdf.text @paciente.nombre_completo,:style => :bold,:align => :center,:size => 10
	pdf.stroke_line [pdf.bounds.left,  pdf.bounds.top],
              [pdf.bounds.right, pdf.bounds.top]
end

pdf.bounding_box([20,510], :width=>500, :height=>250) do
	pdf.font.size = 10
	pdf.text "Fecha de nacimiento: #{l (@paciente.fecha_nac, :format => '%d / %b / %Y')}       (#{@paciente.edad(@fecha_hora)} años #{@paciente.edad_meses(@fecha_hora)}  meses)"
	pdf.text " "
	pdf.text 'Médico que lo envía: ' + @consulta.doctor.nombre_completo unless @consulta.doctor.nil?
	pdf.text " "
	pdf.text 'Diagnóstico: ' + @consulta.diagnostico
	pdf.text " "
	pdf.text 'Resumen del padecimiento:', :size => 12,:spacing => 16,:style => :bold
	pdf.text " "
	pdf.text 'Medicación actual:', :size => 12,:spacing => 16,:style => :bold
	pdf.text  @consulta.medicina_actual
	pdf.text 'Domicilio particular:', :size => 12,:style => :bold
	pdf.text " "
	pdf.text  @paciente.domicilio_completo
	pdf.text " "
	pdf.text 'Teléfonos del contacto', :size => 12,:spacing => 7,:style => :bold
	pdf.text 'Nombre del contacto: ' + @paciente.contacto
end

pdf.bounding_box([300,485], :width=>200, :height=>100) do	
	pdf.text 'Inicio de síntomas: '
	pdf.text  @consulta.fecha_in_sintomas
	pdf.text " "
end

pdf.bounding_box([20,272], :width=>500, :height=>100) do	
	pdf.font.size = 10
	pdf.text "Tel. casa: #{@paciente.tel_casa}",:spacing => 10

	pdf.text "Celular (044):  #{@paciente.tel_cel}"
end
pdf.bounding_box([300,272], :width=>500, :height=>100) do
	pdf.font.size = 10
	pdf.text "e-mail:  #{@paciente.mail}",:spacing => 10

	pdf.text 'Tel. oficina:' + @paciente.tel_oficina
	pdf.text " "
end
pdf.bounding_box([20,229], :width=>500, :height=>120) do
	pdf.font.size = 10
	pdf.stroke_line [pdf.bounds.left,  pdf.bounds.top],
              [pdf.bounds.right, pdf.bounds.top]
	pdf.text 'Datos de Facturación:',:size => 12,:style => :bold
	pdf.text " "
	pdf.text 'Nombre o razón social: ' + @razon,:spacing => 5
	pdf.text " "
	pdf.text 'Domicilio Fiscal:' + @paciente.direccion_fiscal_completa,:spacing => 10
	pdf.text " "
	pdf.text 'RFC: ' + @rfc
end
pdf.bounding_box([20,115], :width=>500, :height=>120) do
	pdf.font.size = 10
	pdf.text 'Forma de pago:'
end
pdf.bounding_box([130,115], :width=>500, :height=>120) do
	pdf.text 'Tarjeta de crédito          American Express          Tarjeta de débito          Cheque          Efectivo'
end
pdf.bounding_box([113,135], :width=>500, :height=>120) do
  	pdf.stroke_rectangle [2,98], 10, 10 
  	pdf.stroke_rectangle [108,98], 10, 10 
  	pdf.stroke_rectangle [216,98], 10, 10 
  	pdf.stroke_rectangle [317,98], 10, 10 
  	pdf.stroke_rectangle [382,98], 10, 10 
end
pdf.bounding_box([200,50], :width=>190, :height=>100) do
	pdf.stroke_line [pdf.bounds.left,  pdf.bounds.top],
                [pdf.bounds.right, pdf.bounds.top]
	pdf.text 'Nombre y Firma',:align => :center
end