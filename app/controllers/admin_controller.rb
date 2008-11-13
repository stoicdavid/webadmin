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

  end
  protected 
  def authorize_admin
  end

end
