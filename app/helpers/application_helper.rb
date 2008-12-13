# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def menu
    if usuario=Usuario.find_by_id(session[:usuario_id])
    
    menu= link_to("Home", :controller => "admin") + "<br /><br />"
    if usuario.nombre=='admin' 
      menu+= link_to("Doctores", :controller => "doctors") + "<br />"
      menu+= link_to("Precios", :controller => "estudios") + "<br />"
      menu+= link_to("Cubículos",:controller => "lab", :action => 'show_horario')+"<br />"
      menu+= link_to("Pagos", :controller => "pagos") +"<br />"
      menu+= link_to( "Citas", :controller => "citas")+ "<br />"
      menu+= link_to( "Estudios", :controller => "operations" )+"<br />"
    end
    
    if usuario.doctor!=nil
      menu+= link_to( "Mi Perfil", :controller => "doctors",:action => "show",:id => usuario.doctor_id)+ "<br />"
      menu+= link_to( "Honorarios", :controller => "lab",:action => "lista_honorarios",:id => usuario.doctor_id)+ "<br />"
    end
    
    if session[:usuario_id]
      menu+= link_to( "Pacientes", :controller => "pacientes")+ "<br />"
      menu+= link_to( "Referencias", :controller => "referencias")+ "<br />"
    end
    menu+=link_to 'Logout', :controller => :admin, :action => 'logout' 
  end
end

end
