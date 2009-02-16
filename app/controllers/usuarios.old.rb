class UsuariosController < ApplicationController
  # GET /usuarios
  # GET /usuarios.xml
  before_filter :login_required
  def index
    @usuarios = Usuario.find(:all, :order => :nombre )

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @usuarios }
    end
  end

  # GET /usuarios/1
  # GET /usuarios/1.xml
  def show
    @usuario = Usuario.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @usuario }
    end
  end

  # GET /usuarios/new
  # GET /usuarios/new.xml
  def new
    @usuario = Usuario.new
    @doctor=Doctor.find_by_id(params[:id])
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @usuario }
    end
  end

  # GET /usuarios/1/edit
  def edit
    @usuario = Usuario.find(params[:id_usuario])
    @doctor=Doctor.find_by_id(params[:id])
  end

  # POST /usuarios
  # POST /usuarios.xml
  def envia_registro(doc,pass)
    email = NeuroMailer.create_registra_doctor(doc,pass) 
    email.set_content_type("text/html")
    NeuroMailer.deliver(email) 
  end
  
  def create
    @usuario = Usuario.new(params[:usuario])
    
    respond_to do |format|
      if @usuario.save
        @password = params[:usuario][:password]
        @doctor = Doctor.find(params[:usuario][:doctor_id])
        envia_registro(@doctor,@password)
        flash[:notice] = "El usuario #{@usuario.login} fue creado exitosamente y se ha enviado un correo a #{@doctor.correo}"
        format.html { redirect_to(:controller => "doctors",:action => "show",:id => @usuario.doctor_id) }
      else
        format.html { redirect_to :action => "new",:id => params[:usuario][:doctor_id] } #:locals => {:id => params[:id]}
        format.xml  { render :xml => @usuario.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /usuarios/1
  # PUT /usuarios/1.xml
  def update
    @usuario = Usuario.find(params[:id])

    respond_to do |format|
      if @usuario.update_attributes(params[:usuario])
        @password = params[:usuario][:password]
        @doctor = Doctor.find(params[:usuario][:doctor_id])
        envia_registro(@doctor,@password)
        flash[:notice] = "El usuario #{@usuario.nombre} fue creado exitosamente y se ha enviado un correo a #{@doctor.correo}"
        format.html { redirect_to(:controller => "doctors",:action => "show",:id => @usuario.doctor_id) }
        format.xml  { head :ok }
      else
        format.html { redirect_to :action => "edit" }
        format.xml  { render :xml => @usuario.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /usuarios/1
  # DELETE /usuarios/1.xml
  def destroy
    @usuario = Usuario.find(params[:id])
    @usuario.destroy

    respond_to do |format|
      format.html { redirect_to(usuarios_url) }
      format.xml  { head :ok }
    end
  end
  
end
