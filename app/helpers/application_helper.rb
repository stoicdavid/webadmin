# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper  
  
  def menu
    if usuario=current_usuario
    
    menu= link_to(t("menu.home"), :controller => "lab",:action => "index") + "<br /><br />"
    
    if logged_in?
      menu+= link_to( t("menu.referencias"), :controller => "referencias")+ "<br /><br />"
      menu+= link_to( t("menu.pacientes"), :controller => "pacientes")+ "<br /><br />"
    end
    
    if usuario.has_role?('admin')
      menu+= link_to(t("menu.usuarios"), :controller => "usuarios") + "<br /><br />"
      menu+= link_to(t("menu.doctores"), :controller => "doctors") + "<br /><br />"
      menu+= link_to(t("menu.precios"), :controller => "estudios") + "<br />"
      menu+= link_to(t("menu.cubiculos"),:controller => "lab", :action => 'show_horario')+"<br /><br />"
      menu+= link_to( t("menu.citas"), :controller => "citas")+ "<br />"
      menu+= link_to( t("menu.estudios"), :controller => "operations" )+"<br /><br />"
      menu+= link_to(t("menu.pagos"), :controller => "pagos") +"<br /><br /><br />"
      menu+= link_to(t("menu.reportes"), :controller => "reportes",:action => "show") +"<br /><br /><br />"
      menu+= link_to(t("menu.interpretaciones"), :controller => "inters") +"<br /><br /><br />"
      menu+= link_to(t("menu.reasigna_cita"), :controller => "lab",:action => 'busca_paciente') +"<br />"
      menu+= link_to(t("menu.envia_correo"), :controller => "lab",:action => 'busca_paciente') +"<br /><br /><br />"
    end
    
    if usuario.has_role?('doctor')
      menu+= link_to( t("menu.mi_perfil"), :controller => "doctors",:action => "show",:id => usuario.doctor_id)+ "<br />"
      menu+= link_to( t("menu.honorarios"), :controller => "lab",:action => "lista_honorarios",:id => usuario.doctor_id)+ "<br /><br />"
    end
    
    if usuario.has_role?('socio')
      menu+= link_to(t("menu.reportes"), :controller => "reportes",:action => "show") +"<br /><br /><br />"
    end
    
    if usuario.has_role?('interprete')
      menu+= link_to(t("menu.interpretaciones"), :controller => "inters") +"<br /><br /><br />"
    end
    
unless usuario.has_role?('doctor')    
      menu+= link_to(t("menu.mi_perfil") , :controller => "usuarios",:action => "show",:id => usuario.id)+ "<br /><br />"
end
    menu+=link_to t("menu.salir"), :controller => :sessions, :action => 'destroy' 
  end
end



end
