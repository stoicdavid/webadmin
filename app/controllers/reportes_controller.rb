class ReportesController < ApplicationController
  
  def grafica
    
    g = Gruff::Bar.new('580x210') #Define a New Graph
    g.font = File.expand_path("/artwork/Vera.ttf", RAILS_ROOT)
    g.title = "Estudios por mes" #Title for the Graph
    g.theme = {
       :colors => ['#ff6600', '#3bb000', '#1e90ff', '#efba00', '#0aaafd'],
       :marker_color => '#aaa',
       :background_colors => ['#eaeaea', '#fff']
     }
    #estudio = Cita.count(:all,:conditions => "status='Pagada'", :group => "DATE_FORMAT(fecha_hora,'%Y-%m')", :order =>"fecha_hora ASC") 
    #agrupar = "strftime('%Y-%m',fecha_hora)"
    agrupar = "DATE_FORMAT(fecha_hora,'%Y-%m')"
    
    estudios = Cita.count(:all, :group => agrupar, :order =>"fecha_hora ASC")
    pagados = Cita.count(:all, :conditions => "status='Pagada'", :group => agrupar, :order =>"fecha_hora ASC")
    activos = Cita.count(:all, :conditions => "status='Activa'", :group => agrupar, :order =>"fecha_hora ASC")
    confirmados = Cita.count(:all, :conditions => "status='Confirmada'", :group => agrupar, :order =>"fecha_hora ASC")
    realizado = Cita.count(:all, :conditions => "status='Estudio Realizado'", :group => agrupar, :order =>"fecha_hora ASC")
    meses = (estudios.keys).sort
    claves = Hash[*meses.collect {|v| [meses.index(v),v.to_s]}.flatten]
    g.data("Pagados", claves.collect {|k,v|pagados[v].nil? ? 0: pagados[v]}) #Graph Data
    g.data("Activos", claves.collect {|k,v|activos[v].nil? ? 0: activos[v]}) #Graph Data
    g.data("Confirmados", claves.collect {|k,v|confirmados[v].nil? ? 0: confirmados[v]}) #Graph Data
    g.data("Finalizado", claves.collect {|k,v|realizado[v].nil? ? 0: realizado[v]}) #Graph Data
    g.labels = claves #Labels for Each of the Graph

    
    send_data(g.to_blob('JPG'), 
              :disposition => 'inline', 
              :type => 'image/jpg', 
              :filename => "prueba.jpg")
  end
  
end
