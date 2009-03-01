class UsuariosController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead

  before_filter :login_required
  require_role "admin", :for_all_except => [:edit,:update,:show]


 def index
   @usuarios = Usuario.find(:all, :order => :login)

   respond_to do |format|
     format.html # index.html.erb
     format.xml  { render :xml => @usuarios }
   end
 end
 def show
    @usuario = Usuario.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @usuario }
    end
  end
  def new
    @usuario = Usuario.new
  end
  
  def edit
    @usuario = Usuario.find(params[:id])
  end

 
  def create
    #logout_keeping_session!
    @usuario = Usuario.new(params[:usuario])
    success = @usuario && @usuario.save
    if success && @usuario.errors.empty?
      # Protects against session fixation attacks, causes request forgery
      # protection if visitor resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      #reset session
      #self.current_usuario = @usuario # !! now logged in
      redirect_back_or_default('/lab/index')
      flash[:notice] = t('flash.nuevo')
    else
      flash[:notice]  = "We couldn't set up that account, sorry.  Please try again, or contact an admin (link is above)."
      render :action => 'new'
    end
  end
  
  def update
    @usuario = Usuario.find(params[:id])
    respond_to do |format|
      if @usuario.update_attributes(params[:usuario])
        flash[:notice] = t('flash.mod')
        format.html { redirect_to(:action => "show",:id => @usuario.id) }
        format.xml  { head :ok }
      else
        format.html { redirect_to :action => "edit"}
        format.xml  { render :xml => @usuario.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def destroy
    @usuario = Usuario.find(params[:id])
    @usuario.destroy

    respond_to do |format|
      format.html { redirect_to(usuarios_url) }
      format.xml  { head :ok }
    end
  end
end
