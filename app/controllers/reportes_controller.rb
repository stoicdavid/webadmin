class ReportesController < ApplicationController
  
  def grafica
    
    g = Gruff::Line.new
    vera_font_path = File.expand_path('Vera.ttf', ENV['MAGICK_FONT_PATH'])
    g.font = File.exists?(vera_font_path) ? vera_font_path : nil
    g.title = "Scores for Bart" 
    g.data("Homer", [75, 85, 83, 90, 85, 94]) 
    g.data("Marge", [40, 65, 57, 49, 28, 59]) 
    g.data("Bart", [90, 87, 83, 80, 75, 70]) 
    g.labels = {0 => '2003', 2 => '2004', 4 => '2005'}

    send_data(g.to_blob, 
              :disposition => 'inline', 
              :type => 'image/png', 
              :filename => "prueba.jpg")
  end
  
end
