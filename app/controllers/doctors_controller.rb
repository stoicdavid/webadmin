class DoctorsController < ApplicationController
  # GET /doctors
  # GET /doctors.xml
  before_filter :login_required
  def index
    if params[:search]
      values = {}
      a = "%#{params[:search]}%".split(/\s+/)
      a.each { |x| values[:str] = x}

      @doctors = Doctor.find(:all, :conditions => ['nombre LIKE :str OR app_pat LIKE :str OR app_mat LIKE :str', values ])
    else
      @doctors = Doctor.find(:all)
    end
    


    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @doctors }
    end
  end

  # GET /doctors/1
  # GET /doctors/1.xml
  def show
    @doctor = Doctor.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @doctor }
    end
  end

  # GET /doctors/new
  # GET /doctors/new.xml
  def new
    @doctor = Doctor.new
    @especialidad = @doctor.build_especialidad
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @doctor }
    end
  end

  # GET /doctors/1/edit
  def edit
    @doctor = Doctor.find(params[:id])
  end

  def crea_usuario
    doctor = Doctor.find(params[:id])
    @usuario = doctor.build_usuario
    @usuario.name = doctor.nombre_completo
    @usuario.email = doctor.correo
  end

  def salva
    
  end


  # POST /doctors
  # POST /doctors.xml
  def create
    @doctor = Doctor.new(params[:doctor])
    @doctor.genera_rfc
    respond_to do |format|
      format.html do
        if @doctor.save
          if !params[:doctor][:especialidad_id].nil?
            @doctor.especialidad_id = Especialidad.find(:last).id
            @doctor.save(false)
          end
          flash[:notice] = "El doctor #{@doctor.nombre_completo} fue creado."
          redirect_to(@doctor)
        else
          render :action => "new"
        end
      end
    end
  end
  
  def update
    @doctor = Doctor.find(params[:id])
    respond_to do |format|
      if @doctor.update_attributes(params[:doctor])
        flash[:notice] = "El doctor #{@doctor.nombre_completo} fue actualizado."
        format.html { redirect_to(@doctor) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @doctor.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def envia_registro(doc,pass)
    email = NeuroMailer.create_registra_doctor(doc,pass) 
    email.set_content_type("text/html")
    NeuroMailer.deliver(email) 
  end


  # DELETE /doctors/1
  # DELETE /doctors/1.xml
  def destroy
    @doctor = Doctor.find(params[:id])
    @doctor.usuario.destroy unless @doctor.usuario.nil?
    @doctor.destroy
    

    respond_to do |format|
      format.html { redirect_to(doctors_url) }
      format.xml  { head :ok }
    end
  end
  
  
end
