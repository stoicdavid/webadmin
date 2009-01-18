	pdf.bounding_box([15,650], :width=>600, :height=>100) do
		pdf.font.size=9
		pdf.text @paciente.razon,:spacing => 5
		pdf.text @paciente.direccion_fiscal_completa,:spacing => 5
		pdf.text 'México, D.F.                                  ' + @fecha +'                                  '+ @rfc
	end
	
	pdf.bounding_box([15,550], :width=>600, :height=>100) do
		pdf.font.size=9
		pdf.text '      1' + '               '+@estudio.tipo_estudio , :spacing => 10
		pdf.text '    	                  ' + @descuento , :spacing => 10
		pdf.text '                       Paciente:  ' + @paciente.nombre_completo 
	end
	
	pdf.bounding_box([415,550], :width=>600, :height=>100) do
		pdf.font.size=9
		pdf.text @pago.precio_f
	end

	pdf.bounding_box([506,550], :width=>600, :height=>100) do
		pdf.font.size=9
		pdf.text @pago.precio_f, :spacing => 15
		pdf.text '  '+@importe_des
	end
	
	
	pdf.bounding_box([180,440], :width=>600, :height=>100) do
		pdf.font.size=8
		pdf.text @pago.total.to_f.to_currency
	end
	
	pdf.bounding_box([506,440], :width=>600, :height=>100) do
		pdf.font.size=9
		pdf.text @pago.subtotal_f, :spacing => 8
		pdf.text '   '+@pago.iva_f, :spacing => 8
		pdf.text @pago.total_f
	end

#other part

	pdf.bounding_box([15,330], :width=>600, :height=>100) do
		pdf.font.size=9
		pdf.text @paciente.razon,:spacing => 5
		pdf.text @paciente.direccion_fiscal_completa,:spacing => 5
		pdf.text 'México, D.F.                                  ' + @fecha +'                                  '+ @rfc
	end
	
	pdf.bounding_box([15,230], :width=>600, :height=>100) do
		pdf.font.size=9
		pdf.text '      1' + '               '+@estudio.tipo_estudio , :spacing => 10
		pdf.text '    	                  ' + @descuento , :spacing => 10
		pdf.text '                       Paciente:  ' + @paciente.nombre_completo 
	end
	
	pdf.bounding_box([415,230], :width=>600, :height=>100) do
		pdf.font.size=9
		pdf.text @pago.precio_f
	end

	pdf.bounding_box([506,230], :width=>600, :height=>100) do
		pdf.font.size=9
		pdf.text @pago.precio_f, :spacing => 15
		pdf.text '  '+@importe_des
	end
	
	
	pdf.bounding_box([180,120], :width=>600, :height=>100) do
		pdf.font.size=8
		pdf.text @pago.total.to_f.to_currency
	end
	
	pdf.bounding_box([506,120], :width=>600, :height=>100) do
		pdf.font.size=9
		pdf.text @pago.subtotal_f, :spacing => 8
		pdf.text '   '+@pago.iva_f, :spacing => 8
		pdf.text @pago.total_f
	end