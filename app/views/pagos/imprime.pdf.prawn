



	pdf.bounding_box([32,662], :width=>600, :height=>100) do
		pdf.font.size=8
		pdf.text @paciente.razon,:spacing => 7
		pdf.text "    " + @paciente.direccion_fiscal_completa,:spacing => 9
		pdf.text "#{@paciente.estado_fis}"
	end
	
	pdf.bounding_box([199,630], :width=>600, :height=>100) do
		pdf.text @fecha
	end
	
	pdf.bounding_box([340,630], :width=>600, :height=>100) do
		pdf.text @rfc
	end
	
	
	pdf.bounding_box([5,550], :width=>600, :height=>100) do
		pdf.font.size=9
		pdf.text '1' + '               '+@estudio.tipo_estudio , :spacing => 10
		pdf.text '                 ' + @descuento , :spacing => 10
		pdf.text '                 Paciente:  ' + @paciente.nombre_completo 
	end
	
	pdf.bounding_box([425,550], :width=>600, :height=>100) do
		pdf.font.size=8
		pdf.text @pago.precio_f
	end

	pdf.bounding_box([499,550], :width=>600, :height=>100) do
		pdf.font.size=8
		pdf.text @pago.precio_f, :spacing => 15
		pdf.text '  '+@importe_des
	end
	
	
	pdf.bounding_box([180,440], :width=>600, :height=>100) do
		pdf.font.size=8
		pdf.text @pago.total.to_f.to_currency
	end
	
	pdf.bounding_box([499,464], :width=>600, :height=>100) do
		pdf.font.size=8
		pdf.text @pago.subtotal_f, :spacing => 10
		pdf.text '   '+@pago.iva_f, :spacing => 10
		pdf.text @pago.total_f
	end

#other part
alfa = 398
pdf.bounding_box([32,647-alfa], :width=>600, :height=>100) do
	pdf.font.size=8
	pdf.text @paciente.razon,:spacing => 7
	pdf.text "    " + @paciente.direccion_fiscal_completa,:spacing => 9
	pdf.text "#{@paciente.estado_fis}"
end


pdf.bounding_box([199,630-alfa], :width=>600, :height=>100) do
	pdf.text @fecha
end

pdf.bounding_box([340,630-alfa], :width=>600, :height=>100) do
	pdf.text @rfc
end



pdf.bounding_box([5,550-alfa], :width=>600, :height=>100) do
	pdf.font.size=9
	pdf.text '1' + '               '+@estudio.tipo_estudio , :spacing => 10
	pdf.text '                 ' + @descuento , :spacing => 10
	pdf.text '                 Paciente:  ' + @paciente.nombre_completo 
end

pdf.bounding_box([425,550-alfa], :width=>600, :height=>100) do
	pdf.font.size=8
	pdf.text @pago.precio_f
end

pdf.bounding_box([499,550-alfa], :width=>600, :height=>100) do
	pdf.font.size=8
	pdf.text @pago.precio_f, :spacing => 15
	pdf.text '  '+@importe_des
end


pdf.bounding_box([180,440-alfa], :width=>600, :height=>100) do
	pdf.font.size=8
	pdf.text @pago.total.to_f.to_currency
end

pdf.bounding_box([499,450-alfa], :width=>600, :height=>100) do
	pdf.font.size=8
	pdf.text @pago.subtotal_f, :spacing => 10
	pdf.text '   '+@pago.iva_f, :spacing => 10
	pdf.text @pago.total_f
end