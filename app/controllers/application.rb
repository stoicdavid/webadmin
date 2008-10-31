# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  layout "lab"
  before_filter :authorize, :except => :login 
  #before_filter :authorize_admin, :except => [:login,:pacientes]

  session:session_key => '_webadmin_session_id' 
  helper :all # include all helpers, all the time
  helper :prototype_window_class
  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery  :secret => 'b5163f2fb1d9a839e923e7b9371885b6'

  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password

  protected 
  def authorize_admin
      unless Usuario.find_by_id(session[:usuario_id]).nombre=='admin'
        flash[:notice] = "Para realizar esta accion debes ser administrador" 
        redirect_to :controller => :admin, :action => :login 
      end 
  end  

  
  def authorize 
    unless Usuario.find_by_id(session[:usuario_id])
      flash[:notice] = "Please log in" 
      redirect_to :controller => :admin, :action => :login 
    end 
  end 
end
  
