2.times do

	pdf.table([[@paciente.razon,'',''],
				[@paciente.direccion_fiscal_completa,'','']],
			  :font_size=>9,
			  :horizontal_padding => 20,
	          :vertical_padding => 3,
	          :border_width =>0,
	          #:position => :center,
	          #:row_colors => ['ffffff','ffffbb'],
	          :headers => [''])
	pdf.table([['México D.F.' + '              ',@fecha,'             	' + @rfc]],
			  :font_size=>9,
			  :horizontal_padding => 20,
	          :vertical_padding => 1,
	          :border_width =>0,
	          #:position => :center,
	          #:row_colors => ['ffffff','ffffbb'],
	          :headers => [''])
	pdf.text " "
	pdf.text " "
	pdf.table([['1','   ','         ','   ','  ' + @estudio.tipo_estudio + ' de ' + @paciente.nombre_completo,'                                      '+ @pago.precio_f,'           ' + @pago.precio_f],
				['','','','','  ' + @descuento,'','            ' + @importe_des]],
			  :font_size=>10,
			  :horizontal_padding => 2,
	          :vertical_padding => 3,
	          :border_width =>0,
	          #:position => :center,
	          #:row_colors => ['ffffff','ffffbb'],
	          :headers => [''])
	pdf.text " "
	pdf.text " "
	pdf.text " "
	pdf.text " "
	pdf.text " "
	pdf.table([['','','','  ',@pago.subtotal_f],['','                             ',@pago.total.to_f.to_currency,'                        ','   ' + @pago.iva_f],['','','','                   ',@pago.total_f]],
			  :font_size=>8,
			  :horizontal_padding => 20,
	          :vertical_padding => 3.5,
	          :border_width =>0,
	          #:position => :center,
	          #:row_colors => ['ffffff','ffffbb'],
	          :headers => [''])
	pdf.text " "
	pdf.text " "
	pdf.text " "
	pdf.text " "
	pdf.text " "
	pdf.text " "
	pdf.text " "
	pdf.text " "
	pdf.text " "
	pdf.text " "

end