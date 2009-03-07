class Simple < Rupdf::Base

  define_variables :report_title
  renders :pdf, :for => Rupdf::Renderer

  define_header do
    add_header(report_title)
  end

  define_body do
    add_text("hello man\n\n\n")
    add_text("bye man.")

    add_text("bye man.")
    add_text("hello man\n\n\n")
    add_text("bye man.")
    add_text("hello man\n\n\n")
    add_text("bye man.")

    add_text("hello man\n\n\n")
    add_text("bye man.")
    add_text("hello man\n\n\n")

  end

  define_footer do
    footer_text = %(
    This is the beautiful footer text.
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
