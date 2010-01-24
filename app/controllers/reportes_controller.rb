class ReportesController < ApplicationController
  require 'spreadsheet'
  
  def grafica
  
    g = Gruff::Bar.new('600x210') #Define a New Graph
    g.font = File.expand_path("/artwork/Vera.ttf", RAILS_ROOT)
    g.title = "Estudios por mes" #Title for the Graph
    g.theme = {
       :colors => ['#ff6600', '#3bb000', '#1e90ff', '#efba00', 'grey','red'],
       :marker_color => '#aaa',
       :background_colors => ['#eaeaea', '#fff']
     }
    #estudio = Cita.count(:all,:conditions => "status='Pagada'", :group => "DATE_FORMAT(fecha_hora,'%Y-%m')", :order =>"fecha_hora ASC") 

    agrupar = RAILS_ENV=="production" ? "DATE_FORMAT(fecha_hora,'%Y-%m')": "strftime('%Y-%m',fecha_hora)"
    
    estudios = Cita.count(:all, :group => agrupar, :order =>"fecha_hora ASC")
    
    
    pagados = Cita.count(:all, :conditions => "status_pago='estudio_pagado'", :group => agrupar, :order =>"fecha_hora ASC")
    activos = Cita.count(:all, :conditions => "status='activa'", :group => agrupar, :order =>"fecha_hora ASC")
    confirmados = Cita.count(:all, :conditions => "status='confirmada'", :group => agrupar, :order =>"fecha_hora ASC")
    realizados = Cita.count(:all, :conditions => "status='estudio_exitoso'", :group => agrupar, :order =>"fecha_hora ASC")
    cancelados = Cita.count(:all, :conditions => "status='cancelada'", :group => agrupar, :order =>"fecha_hora ASC")
    interpretados = Cita.count(:all, :conditions => "status='estudio_interpretado'", :group => agrupar, :order =>"fecha_hora ASC")
    meses = estudios.keys.sort
    claves = Hash[*meses.collect {|v| [meses.index(v),v.to_s]}.flatten]
    g.data("Pagados", claves.sort.collect {|k,v|pagados[v].nil? ? 0: pagados[v]}) #Graph Data
    g.data("Activos", claves.sort.collect {|k,v|activos[v].nil? ? 0: activos[v]}) #Graph Data
    g.data("Confirmados", claves.sort.collect {|k,v|confirmados[v].nil? ? 0: confirmados[v]}) #Graph Data
    g.data("Exitosos", claves.sort.collect {|k,v|realizados[v].nil? ? 0: realizados[v]}) #Graph Data
    g.data("Cancelados", claves.sort.collect {|k,v|cancelados[v].nil? ? 0: cancelados[v]}) #Graph Data
    g.data("Interpretados", claves.sort.collect {|k,v|interpretados[v].nil? ? 0: interpretados[v]}) #Graph Data
    g.labels = claves #Labels for Each of the Graph

    send_data(g.to_blob('JPG'), 
              :disposition => 'inline', 
              :type => 'image/jpg', 
              :filename => "prueba.jpg")
  end
  
  def grafica_2
      g = Gruff::Bar.new('580x210') #Define a New Graph
      g.font = File.expand_path("/artwork/Vera.ttf", RAILS_ROOT)
      g.title = "Tipos de Estudio" #Title for the Graph
      g.theme = {
         :colors => ['#ff6600', '#3bb000', '#1e90ff', '#efba00', '#0aaafd'],
         :marker_color => '#aaa',
         :background_colors => ['#eaeaea', '#fff']
       }
      operaciones = Operation.count(:all, :group => 'tipo_id',:order => "tipo_id ASC")
      tipos = operaciones.keys.sort
      claves = Hash[*tipos.collect {|v| [tipos.index(v),Estudio.find(v).tipo_estudio]}.flatten]
      g.data("Tipos", claves.sort.collect {|k,v|operaciones[k+1].nil? ? 0: operaciones[k+1]}) #Graph Data
      g.labels = claves #Labels for Each of the Graph
      send_data(g.to_blob('JPG'), 
                :disposition => 'inline', 
                :type => 'image/jpg', 
                :filename => "prueba_2.jpg")

    
  end
  
  def reporte_xls
    book = Spreadsheet::Workbook.new
    sheet1 = book.create_worksheet :name => 'hoja1'
    sheet1.row(0).concat %w{Mes Estudios Ingreso Comisión_Doctor Comisión_Bancaria Impuesto Total}
    agrupar = RAILS_ENV=="production" ? "DATE_FORMAT(fecha_hora,'%Y-%m')": "strftime('%Y-%m',fecha_hora)"    
    estudios = Cita.count(:all, :conditions => "status_pago='estudio_pagado'", :group => agrupar)
    importes = Cita.sum(:total,:conditions => "status_pago='estudio_pagado'",
    :include => [:operation,{:operation => :pago}],:group => agrupar)
    meses = estudios.keys.sort
    meses.each_with_index do |mes,index|
       sheet1[index+1,0]=mes
     end
    estudios.values.each_with_index do |num,idx|
       sheet1[idx+1,1]=num
    end
    importes.values.each_with_index do |total,idx|
       sheet1[idx+1,2]=total.to_f
    end
    book.write "#{RAILS_ROOT}/public/prueba.xls"
    send_file "#{RAILS_ROOT}/public/prueba.xls"
  end
  
  def reporte_2_xls
    book = Spreadsheet::Workbook.new
    sheet1 = book.create_worksheet :name => 'hoja1'
    sheet1.row(0).concat %w{Fecha Nombre Tipo_estudio Consecutivo No_Estudio Doctor No_Factura Comision Cheque Efectivo Transferencia Tarjeta_debito Tarjeta_credito Amex Banco}
    estudios = Cita.find(:all, :conditions => {:status => ['estudio_exitoso','estudio_interpretado']},:order => "fecha_hora ASC",:include => [:paciente,:operation,:consulta])
    estudios.each_with_index  do |estudio, idx|
      sheet1[idx+1,0]=estudio.fecha_hora
      sheet1[idx+1,1]=estudio.paciente.nombre_completo
      sheet1[idx+1,2]=Estudio.find(estudio.consulta.estudio_id).tipo_estudio
      sheet1[idx+1,3]=idx + 1
      sheet1[idx+1,4]=estudio.operation.ref_estudio
      sheet1[idx+1,5]=estudio.consulta.doctor.nombre_completo unless estudio.consulta.doctor.nil?
      sheet1[idx+1,6]=estudio.operation.pago.folio_factura unless estudio.operation.pago.nil?
      sheet1[idx+1,7]=estudio.operation.pago.total unless estudio.operation.pago.nil?
      sheet1[idx+1,8]=estudio.operation.pago.forma_pago unless estudio.operation.pago.nil?
    end
    book.write "#{RAILS_ROOT}/public/reporte_detalle.xls"
    send_file "#{RAILS_ROOT}/public/reporte_detalle.xls"
  end  
  
  
end
