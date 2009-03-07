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
    estudio = Operation.count(:all, :group => "strftime('%Y-%m',created_at)", :order =>"created_at ASC")
    meses = (estudio.keys).sort
    claves = Hash[*meses.collect {|v| [meses.index(v),v.to_s]}.flatten]
    g.data("Estudios", claves.collect {|k,v|estudio[v].nil? ? 0: estudio[v]}) #Graph Data
    g.labels = claves #Labels for Each of the Graph

    
    send_data(g.to_blob('JPG'), 
              :disposition => 'inline', 
              :type => 'image/jpg', 
              :filename => "prueba.jpg")
  end
  
end
