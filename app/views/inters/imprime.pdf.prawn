

pdf.bounding_box([300,240], :width => 200, :height => 400) do
	pdf.text "REPORTE ENCEFALOGRAFICO",:align => :right,:spacing => 15
	pdf.font.size = 10
	pdf.text "Nombre: #{@paciente.nombre_completo}",:spacing => 15,:align => :right
	pdf.text "Fecha Estudio: #{l @consulta.cita.fecha_hora,:format=>'%d %b %Y'}",:spacing => 15,:align => :right
	pdf.text "Edadd: #{@paciente.edad(@consulta.cita.fecha_hora)} años #{@paciente.edad_meses(@consulta.cita.fecha_hora)} meses",:spacing => 15,:align => :right
	pdf.text "No. Estudio: #{@estudio}",:align => :right
end
pdf.start_new_page

pdf.bounding_box([32,660], :width => 400, :height => 400) do
	pdf.font.size=12
	pdf.text "REPORTE ENCEFALOGRÁFICO",:spacing => 12
	pdf.font.size=8
	pdf.text "Nombre: #{@paciente.nombre_completo}",:spacing => 4
	pdf.text "Fecha Estudio: #{l @consulta.cita.fecha_hora,:format=>'%d %b %Y'}",:spacing => 4
	pdf.text "Edadd: #{@paciente.edad(@consulta.cita.fecha_hora)} años #{@paciente.edad_meses(@consulta.cita.fecha_hora)} meses",:spacing => 4
	pdf.text "No. Estudio: #{@estudio}"
end
pdf.move_down(10)
pdf.bounding_box([32,580], :width => 350, :height => 500) do
	pdf.text @inter.principal,:size => 8,:spacing=>6
	pdf.move_down(20)
	pdf.text "ACTIVACIONES", :size => 10,:spacing => 12
	pdf.text @inter.activaciones,:spacing => 6,:size => 8
	pdf.move_down(20)
	pdf.text "CONCLUSIÓN", :size => 10,:spacing =>12
	pdf.text @inter.conclusion,:spacing => 3,:size => 8
end
pdf.bounding_box([32,90], :width=>600, :height=>100) do
	pdf.font.size=10
	pdf.text "Atentamente: ",:spacing => 25
	pdf.text "AMERICAN NEUROLAB, INC."
	pdf.text "SEMH Cédula Prof: 3340271",:spacing => 9
end