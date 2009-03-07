module Rupdf
  
  class Renderer < Ruport::Renderer   
    
    
    finalize :document
    #option :report_title
    
    def run
      check_respond_to?
      self.formatter.build_footer
      self.formatter.build_header
      self.formatter.build_body
      self.formatter.finalize_document
    end
    
    def check_respond_to?
      unless (self.formatter.respond_to?(:build_footer) && 
            self.formatter.respond_to?(:build_header) && 
            self.formatter.respond_to?(:build_body))
            
      raise StandardError, "You must call class methods define_header, define_body and define_footer. Before you can generate a pdf."
      
      end
    end
    
  end
  
  # This class adds some more helpers to common pdf-writer functions
  class Base < Ruport::Formatter::PDF
    
    # This is useful for adding a persistent page objects 
    # such as a header or a footer to all pages. Not this is not required 
    # when calling the define_header and define_footer class methods.
    def add_persistent_object
      pdf_writer.open_object do |object|
        yield
        pdf_writer.close_object
        pdf_writer.add_object(object, :all_pages)
      end
    end
    
    # Set the margins in points. This is useful for the main body. To avoid
    # overlapping the headers and footers.
    def margins(top, left, bottom, right)
      pdf_writer.margins_pt(top, left, bottom, right)
    end
    
    
    # Simple images addition in line with the current pdf point
    # please refer to pdfwriter rdoc for options list.
    def image(image_path, options = {})
      pdf_writer.image(image_path, options)
    end
    
    # Positioned image. You must pass the coordinates where the image is to be added.
    # Coordinates define the position of the top right of the image.
    def image_positioned(image_path, x, y, width = nil, height = nil)
      pdf_writer.add_image_from_file(image_path, x, y, width, height)
    end
    
    # Start a new page
    def new_page
      pdf_writer.start_new_page
    end
    
    # Extend this class and call this method in a block format to
    # define the header.
    def self.define_header &block
      define_method "build_header" do
        add_persistent_object do
          instance_eval(&block)
        end
      end
    end
    
    # Extend this class and call this method in a block format
    # to define the body. Default margins are set. Please redefine by calling
    # the margins method.
    def self.define_body &block
      define_method "build_body" do 
        margins(150, 70, 150, 70)
        instance_eval(&block)
      end
    end
    
    # Extend this class and call this method to define a footer.
    def self.define_footer &block
      define_method "build_footer" do
        add_persistent_object do
          instance_eval(&block)
        end
      end
    end
    
    
    # This makes the call to actually render the pdf.
    def finalize_document
      render_pdf
    end
    
    
    # Define configuration variables which can be passed at runtime
    # when generating the pdf.
    def self.define_variables(*args)
      args.each do |var|
        self.opt_reader var
        Renderer.option var
      end
    end
    
  end
  
    
end