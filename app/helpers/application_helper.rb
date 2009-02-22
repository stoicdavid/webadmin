# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def menu
    if usuario=current_usuario
    
    menu= link_to("Home", :controller => "lab",:action => "index") + "<br /><br />"
    
    if session[:usuario_id]
      menu+= link_to( "Referencias", :controller => "referencias")+ "<br /><br />"
      menu+= link_to( "Pacientes", :controller => "pacientes")+ "<br /><br />"
    end
    
    if usuario.has_role?('admin')
      menu+= link_to("Usuarios", :controller => "usuarios") + "<br /><br />"
      menu+= link_to("Doctores", :controller => "doctors") + "<br /><br />"
      menu+= link_to("Precios", :controller => "estudios") + "<br />"
      menu+= link_to("Cubículos",:controller => "lab", :action => 'show_horario')+"<br /><br />"
      menu+= link_to( "Citas", :controller => "citas")+ "<br />"
      menu+= link_to( "Estudios", :controller => "operations" )+"<br /><br />"
      menu+= link_to("Pagos", :controller => "pagos") +"<br /><br /><br />"
      menu+= link_to("Reasigna Cita", :controller => "lab",:action => 'busca_paciente') +"<br />"
      menu+= link_to("Envía Correo", :controller => "lab",:action => 'busca_paciente') +"<br /><br /><br />"
    end
    
    if usuario.has_role?('doctor')
      menu+= link_to( "Mi Perfil", :controller => "doctors",:action => "show",:id => usuario.doctor_id)+ "<br />"
      menu+= link_to( "Honorarios", :controller => "lab",:action => "lista_honorarios",:id => usuario.doctor_id)+ "<br /><br />"
    end
    

    menu+=link_to 'Salir', :controller => :sessions, :action => 'destroy' 
  end
end

end
