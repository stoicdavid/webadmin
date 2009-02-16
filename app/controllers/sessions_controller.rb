# This controller handles the login/logout function of the site.  
class SessionsController < ApplicationController
  before_filter :login_required, :only => :destroy
  layout "admin"
  # render new.rhtml
  def new
  end

  def create
    logout_keeping_session!
    usuario = Usuario.authenticate(params[:login], params[:password])
    if usuario
      # Protects against session fixation attacks, causes request forgery
      # protection if user resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset_session
      self.current_usuario = usuario
      new_cookie_flag = (params[:remember_me] == "1")
      handle_remember_cookie! new_cookie_flag
      redirect_back_or_default('/lab/index')
      flash[:notice] = "Bienvenido"
    else
      note_failed_signin
      @login       = params[:login]
      @remember_me = params[:remember_me]
      render :action => 'new'
    end
  end

  def destroy
    logout_killing_session!
    flash[:notice] = "Has finalizado tu sesión"
    redirect_back_or_default('/')
  end

protected
  # Track failed login attempts
  def note_failed_signin
    flash[:notice] = "No pudiste ingresar como '#{params[:login]}'"
    logger.warn "Ingreso incorrecto para '#{params[:login]}' desde #{request.remote_ip} el dia #{Time.now.utc}"
  end
end
