class ReportesController < ApplicationController
  
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
  
  
end
