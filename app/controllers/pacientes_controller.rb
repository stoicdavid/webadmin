class PacientesController < ApplicationController
  # GET /pacientes
  # GET /pacientes.xml
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
    elsif @usuario.nombre=='admin'
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
    @consulta = Consulta.find(params[:consulta_id])
    if !@consulta.cita.nil?
     @ref_estudio = @consulta.cita.operation.ref_estudio unless @consulta.cita.operation.ref_estudio.nil?
    else
      @ref_estudio = ""
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
    @paciente.consultas.build
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @paciente }
    end
  end

  # GET /pacientes/1/edit
  def edit
    @paciente = Paciente.find(params[:id])
  end

  # POST /pacientes
  # POST /pacientes.xml
  def create
    @paciente = Paciente.new(params[:paciente])
    @paciente.fecha_nac=params[:fecha_nac]
    @paciente.genera_rfc
    respond_to do |format|
      if @paciente.save

        flash[:notice] = 'El Paciente se creo exitosamente'
        format.html { redirect_to(@paciente) }
        format.xml  { render :xml => @paciente, :status => :created, :location => @paciente }

      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @paciente.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /pacientes/1
  # PUT /pacientes/1.xml
  def update
    @paciente = Paciente.find(params[:id])

    respond_to do |format|
      if @paciente.update_attributes(params[:paciente])
        flash[:notice] = 'Paciente was successfully updated.'
        format.html { redirect_to(@paciente) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @paciente.errors, :status => :unprocessable_entity }
      end
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
  
  protected 
  def authorize
  end

end
