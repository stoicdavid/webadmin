class PacientesController < ApplicationController
  # GET /pacientes
  # GET /pacientes.xml
  before_filter :login_required
  def index
    @usuario=current_usuario
    if params[:search] and @usuario.has_role?('admin') or @usuario.has_role?("socio") or @usuario.has_role?("gerente") or @usuario.has_role?("interprete")
      values={}
      nombre = "%#{params[:search]}%".split(/\s+/)
      nombre.each { |x| values[:str] = x}
      @pacientes = Paciente.paginate(:all,
      :conditions => ['nombre LIKE :str or app_pat LIKE :str or app_mat LIKE :str',values], :page => params[:page],:per_page => 10)

    elsif params[:search] and @usuario.has_role?('doctor') and doctor = @usuario.doctor
      values={}
      nombre = "%#{params[:search]}%".split(/\s+/)
      nombre.each { |x| values[:str] = x}
      @pacientes = doctor.pacientes.paginate(:all,
      :conditions => ['nombre LIKE :str or app_pat LIKE :str or app_mat LIKE :str',values], :page => params[:page],:per_page => 5)
    elsif doctor = @usuario.doctor and @usuario.has_role?('doctor')
      @pacientes = doctor.pacientes.paginate(:all,:page => params[:page],:per_page => 5)
    elsif @usuario.has_role?('admin') or @usuario.has_role?("socio") or @usuario.has_role?("gerente")
      consultas = Cita.find_all_by_fecha_hora(Time.now.beginning_of_day...Time.now.end_of_day)
      consultas.each { |paciente|
      @pacientes = Paciente.paginate_by_id(paciente.paciente_id, :page => params[:page],:per_page => 10)
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
                    :top_margin => 400,
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
    @paciente.attributes= params[:paciente]
    @paciente.fecha_nac=params[:fecha_nac] unless params[:fecha_nac].nil?
    respond_to do |format|

      if @paciente.save
        flash[:notice] = 'El paciente ha sido actualizado.'
        format.html {redirect_to(@paciente) }
        format.json {render :json => @paciente}
      else
        format.html {render :action => "edit" }
        format.json {render :json => @paciente,:status => 201}
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
