class Role < ActiveRecord::Base
  
  def traduce_rol
    I18n.translate("roles.#{self.name}")
  end
  
end