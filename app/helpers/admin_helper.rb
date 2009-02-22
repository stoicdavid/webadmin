module AdminHelper
  def principal
    usuario = current_usuario
    menu= link_to( "Pacientes", :controller => "pacientes") +"<br />"
    if usuario.has_role?('admin')
      menu+= link_to( "Doctores", :controller => "doctors") + "<br />"
    end
    menu+=link_to('Logout', :controller => :admin, :action => 'logout') +"</br>" 
  end
  
end
