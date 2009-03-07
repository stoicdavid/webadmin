class Report < Rupdf::Base
   
  define_variables :report_title, :smile_path
  renders :pdf, :for => Rupdf::Renderer   
  
  define_header do
    add_header(report_title)
  end
  
  define_body do 
    add_text("hello man\n\n\n")
    add_text("bye man.")
    add_text("hello man\n\n\n")
    add_text("bye man.")
    add_text("hello man\n\n\n")
    add_text("bye man.")
    add_text("hello man\n\n\n")
    add_text("bye man.")
    add_text("hello man\n\n\n")
    add_text("bye man.")
    add_text("hello man\n\n\n")
    
    # add image (path defined at runtime)
    image(smile_path)
    
    add_text("bye man.")
    add_text("hello man\n\n\n")
    add_text("bye man.")
    add_text("hello man\n\n\n")
    add_text("bye man.")
    add_text("hello man\n\n\n")
    add_text("bye man.")
    add_text("hello man\n\n\n")
    add_text("bye man.")
    add_text("hello man\n\n\n")
    add_text("bye man.")
    add_text("hello man\n\n\n")
    add_text("bye man.")
    add_text("hello man\n\n\n")
    add_text("bye man.")
    add_text("hello man\n\n\n")
    add_text("bye man.")
    add_text("hello man\n\n\n")
    add_text("bye man.")
    
  end
  
  define_footer do
    footer_text = %(
      This is the footer text.
      )
    add_footer(footer_text)
  end
  
  
  def add_header(title)
    rounded_text_box("<b>#{title}</b>") do |o|
      header_color = Color::RGB.from_html("#FFDE16")
      o.fill_color = header_color
      o.stroke_color = header_color
      o.radius     = 0  
      o.width      = options.header_width || 550
      o.height     = options.header_height || 80
      o.font_size  = options.header_font_size || 12
      o.x          = pdf_writer.absolute_right_margin - o.width 
      o.y          = pdf_writer.absolute_top_margin
    end
    
    image_path = RAILS_ROOT + '/public/images/logo.jpg'
    options = {
      :x => 50,
      :y => 670,
      :width => 200,
      :height => 100
    }
    center_image_in_box(image_path, options)
    
    image_path = RAILS_ROOT + '/public/images/page_title.jpg'
    options = {
      :x => 350,
      :y => 667,
      :width => 200,
      :height => 100
    }
    center_image_in_box(image_path, options)
    
  end
  
  def add_footer(text, options = nil)
    
    unless options
      options = OpenStruct.new(:font_size => 6)
    end
    
    rounded_text_box(text) do |o|
      footer_color = Color::RGB.from_html("#EAECEE")
      o.fill_color = footer_color
      o.stroke_color = footer_color
      o.radius     = 0  
      o.width      = options.header_width || 550
      o.height     = options.header_height || 60
      o.font_size  = options.font_size || 12
      o.x          = pdf_writer.absolute_right_margin - o.width
      o.y          = pdf_writer.absolute_bottom_margin + o.height
    
    end
    

    
    
  end
  
  
  
  
end