class Inter < ActiveRecord::Base
  
  belongs_to :operation

  has_attachment :content_type => 'application/msword', 
                  :storage => :file_system, :path_prefix => 'public/diagnosticos'

  validate :attachment_valid? 
  
  def attachment_valid? 
    unless self.filename 
      errors.add_to_base("No se ha seleccionado ningún archivo.") 
    end 
  
    content_type = attachment_options[:content_type] 
    unless content_type.nil? || content_type.include?(self.content_type) 
      errors.add_to_base("El documento seleccionado debe ser de Word") 
    end
  end
  
end
