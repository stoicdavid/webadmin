class AdminController < ApplicationController




  def login 
    session[:usuario_id] = nil 
    if request.post? 
      usuario = Usuario.authenticate(params[:nombre], params[:password]) 
      if usuario 
        session[:usuario_id] = usuario.id 
        redirect_to :action => "index",:controller => 'lab'
      else 
        flash.now[:notice] = "El usuario o password es inválido" 
      end 
    end 
  end


  def logout 
    session[:usuario_id] = nil 
    flash[:notice] = "Has finalizado tu sesión" 
    redirect_to(:action => "login") 
  end

  
  def index

  end
  
  
  protected 
  def authorize_admin
  end

end
