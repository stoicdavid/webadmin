class CitasController < ApplicationController
  # GET /citas
  # GET /citas.xml
  def index
    @mes_actual = Time.now
    @mes_anterior = 1.month.ago(@mes_actual)
    @mes_sig = 1.month.since(@mes_actual)
    @citas = Cita.find_all_by_fecha_hora(@mes_actual.beginning_of_month...@mes_actual.end_of_month)
    
    @dates = @citas.collect { |p| p.fecha_hora.strftime('%d-%m-%Y') }
    
    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /citas/1
  # GET /citas/1.xml
  def show
    @cita = Cita.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @cita }
    end
  end

  # GET /citas/new
  # GET /citas/new.xml
  def new
    @cita = Cita.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @cita }
    end
  end

  # GET /citas/1/edit
  def edit
    @cita = Cita.find(params[:id])
  end

  # POST /citas
  # POST /citas.xml
  def create
    @cita = Cita.new(params[:cita])

    respond_to do |format|
      if @cita.save
        flash[:notice] = 'Cita was successfully created.'
        format.html { redirect_to(@cita) }
        format.xml  { render :xml => @cita, :status => :created, :location => @cita }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @cita.errors, :status => :unprocessable_entity }
      end
    end
  end


  # PUT /citas/1
  # PUT /citas/1.xml
  def update
    @cita = Cita.find(params[:id])

    if @cita.status == 'Activa'
      @cita.status = 'Confirmada'
      @cita.save
    else
      
    end

    respond_to do |format|
      if @cita.update_attributes(params[:cita])
        if @cita.status == 'Sin Cita'
          @cita.status = 'Activa'
          @cita.save
        elsif @cita.status == 'Activa'
          @cita.status = 'Confirmada'
          @cita.save
        end
        flash[:notice] = 'La cita fue actualizada.'
        format.html { redirect_to :controller => 'admin',:action => 'index' }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @cita.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def update_calendario
    @mes_actual = Time.parse(params[:id])
    @mes_anterior = 1.month.ago(@mes_actual)
    @mes_sig = 1.month.since(@mes_actual)
    @citas = Cita.find_all_by_fecha_hora(@mes_actual.beginning_of_month...@mes_actual.end_of_month)
    @dates = @citas.collect { |p| p.fecha_hora.strftime('%d-%m-%Y') }    
    render :update do |page|
      page['calendario'].replace_html :partial => "calendar" 
      page['calendario'].visual_effect 'appear', :duration => 1.3

      
    end        
  end
  
  def asigna_cita
    @dia = params[:id]
    @cita = Cita.new
    @paciente = @cita.build_paciente
    @consulta = @paciente.consultas.build
    
  end
  
  
  def confirma
    @cita = Cita.find(params[:id])
    render :partial => 'confirma', :layout => 'lab'
  end

  def por_dia
    @citas = Cita.find_all_by_fecha_hora(Time.now.beginning_of_day...Time.now.end_of_day)
    @cita_horas = @citas.group_by { |t| t.fecha_hora.hour}
    render :partial => "por_dia", :layout =>  "lab"
  end
  
  def por_semana
    @citas = Cita.find_all_by_fecha_hora(Time.now.beginning_of_week...Time.now.end_of_week)
    @cita_dias = @citas.group_by { |t| t.fecha_hora.beginning_of_day}
    render :partial => "por_semana" , :layout =>  "lab"
  end

  def por_mes
    @citas = Cita.find_all_by_fecha_hora(Time.now.beginning_of_month...Time.now.end_of_month)
    @cita_dias = @citas.group_by { |t| t.fecha_hora.beginning_of_day}
    render :partial => "por_mes" , :layout =>  "lab"
  end

  # DELETE /citas/1
  # DELETE /citas/1.xml
  def destroy

    @cita = Cita.find(params[:id])
    paciente_id=@cita.paciente_id
    Operation.delete_all "cita_id = #{@cita.id}"
    consulta=Consulta.find_by_cita_id(params[:id])
    consulta.update_attributes(:cita_id => nil)
    @cita.destroy
    
    respond_to do |format|
      format.html { redirect_to :controller => "lab",:action => "crea_cita",:id => paciente_id,:id_cons => consulta.id  }
      format.xml  { head :ok }
    end
  end
  protected
  def authorize_admin
  end
end
