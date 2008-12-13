class AdminController < ApplicationController


  def login 
    session[:usuario_id] = nil 
    if request.post? 
      usuario = Usuario.authenticate(params[:nombre], params[:password]) 
      if usuario 
        session[:usuario_id] = usuario.id 
        redirect_to(:action => "index") 
      else 
        flash.now[:notice] = "Invalid user/password combination" 
      end 
    end 
  end


  def logout 
    session[:usuario_id] = nil 
    flash[:notice] = "Logged out" 
    redirect_to(:action => "login") 
  end

  
  def index
    @citas = Cita.find(:all)
    @dates = @citas.collect { |p| p.fecha_hora.strftime('%d-%m-%Y') }
    @consultas_hoy = Cita.find_all_by_fecha_hora(Time.now.beginning_of_day...Time.now.end_of_day)
    @confirma_hoy = Cita.find_all_by_fecha_hora(1.day.since(Time.now.beginning_of_day)...2.day.since(Time.now.end_of_day), :conditions => ['status = ?','Activa'])
    @sin_confirma = Cita.find_all_by_status('Activa')
  end
  protected 
  def authorize_admin
  end

end
