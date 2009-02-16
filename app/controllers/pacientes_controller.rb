class PacientesController < ApplicationController
  # GET /pacientes
  # GET /pacientes.xml
  before_filter :login_required
  def index
    @usuario=Usuario.find_by_id(session[:usuario_id])
    if params[:search]
      values={}
      nombre = "%#{params[:search]}%".split(/\s+/)
      nombre.each { |x| values[:str] = x}
      @pacientes = Paciente.find(:all,
      :conditions => ['nombre LIKE :str or app_pat LIKE :str or app_mat LIKE :str',values])
    elsif doctor = @usuario.doctor
      @pacientes = doctor.pacientes
    elsif @usuario.has_role?('admin')
      consultas = Consulta.find_all_by_fecha_consulta(Time.now.beginning_of_day...Time.now.end_of_day)
      @pacientes = Array.new
      consultas.each { |paciente|
      @pacientes << Paciente.find(paciente.paciente_id)
      }
    end
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pacientes }
    end
  end

  # GET /pacientes/1
  # GET /pacientes/1.xml
  
  def imprime_ficha
     prawnto :prawn => {
                    :left_margin => 20,
                    :right_margin => 20,
                    :top_margin => 20,
                    :bottom_margin => 20 }
    @paciente = Paciente.find(params[:id])                
    @razon = ""
    @razon = @paciente.razon unless @paciente.razon.nil?
    @rfc = ""
    @rfc = @paciente.rfc unless @paciente.rfc.nil?
    @consulta = Consulta.find(params[:consulta_id])
    if !@consulta.cita.nil?
      @ref_estudio = @consulta.cita.operation.ref_estudio unless @consulta.cita.operation.ref_estudio.nil?
      @fecha_hora = @consulta.cita.fecha_hora unless @consulta.cita.fecha_hora.nil?
    else
      @ref_estudio = ""
      @fecha_hora = ""
    end
     respond_to do |format|
        #format.html # show.html.erb
        #format.xml  { render :xml => @pago }
        format.pdf {render :layout => false }
    end
  end
  
  
  def show
    @paciente = Paciente.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @paciente }

    end
  end

  # GET /pacientes/new
  # GET /pacientes/new.xml
  def new
    @paciente = Paciente.new
    @consulta = @paciente.consultas.build
    @consulta.estudio_id = Estudio.find(1)
    respond_to do |format|
      format.html # new.html.erb
      #format.xml  { render :xml => @paciente }
    end
  end

  # GET /pacientes/1/edit
  def edit
    @paciente = Paciente.find(params[:id])
    @fecha_nac = @paciente.fecha_nac.strftime('%d-%m-%Y')
    @consulta = Consulta.find_by_paciente_id(@paciente.id)
  end

  # POST /pacientes
  # POST /pacientes.xml
  def create
    @paciente = Paciente.new(params[:paciente])
    @paciente.fecha_nac=params[:fecha_nac]
    @paciente.genera_rfc
    respond_to do |format|
      format.html do
        if @paciente.save
          flash[:notice] = 'El Paciente se creo exitosamente'
          redirect_to(@paciente)
        else
          render :action => "new"
        end
      end
      format.js { render :action => 'validar'}
    end
  end

  # PUT /pacientes/1
  # PUT /pacientes/1.xml
  def update
    @paciente = Paciente.find(params[:id])    
    @paciente.attributes = params[:paciente]
    @paciente.fecha_nac=params[:fecha_nac]
    respond_to do |format|
      format.html do
      if @paciente.save
        flash[:notice] = 'El paciente ha sido actualizado.'
        redirect_to(@paciente) 
      else
        render :action => "edit" 
        format.xml  { render :xml => @paciente.errors, :status => :unprocessable_entity }
      end
    end
    format.js { render :action => 'validar'}
  end
end

  def crea_consulta
    redirect_to :controller => "consultas", :id => params[:id], :action => 'edit'
  end


  # DELETE /pacientes/1
  # DELETE /pacientes/1.xml
  def destroy
    @paciente = Paciente.find(params[:id])
    @paciente.destroy
    respond_to do |format|
      format.html { redirect_to(pacientes_url) }
      format.xml  { head :ok }
    end
  end
  


end
