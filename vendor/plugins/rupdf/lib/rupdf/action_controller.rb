module ActionController

  module Streaming
  
    Export = Struct.new("Export", :data, :content_type, :name)
  
    def send_to_browser(export)
      send_data(export.data, 
      :filename => export.name, 
      :content_type => export.content_type,
      :disposition => "inline")
    end
    
    def send_pdf(pdf_data)
      export = Export.new(pdf_data, 'application/pdf', 'report.pdf')
      send_to_browser(export)
    end
    
    
  end

end