class ConsultasController < ApplicationController
  # GET /consultas
  # GET /consultas.xml
  before_filter :login_required
  def index
    
    if params[:search]
      values = {}
      a = "%#{params[:search]}%".split(/\s+/)
      a.each { |x| values[:str] = x}

      @consultas = Consulta.find_by_paciente_id(:first)

    end
      @consultas = Consulta.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @consultas }
    end
  end

  # GET /consultas/1
  # GET /consultas/1.xml
  def show
    @consulta = Consulta.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @consulta }
    end
  end

  # GET /consultas/new
  # GET /consultas/new.xml
  def new
    @consul = Consulta.new
    #@consul.paciente_id=params[:id]
    #@consul.save(false)   
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @consul }
    end
  end

  # GET /consultas/1/edit
  def edit
    @consulta = Consulta.find(params[:id])
  end

  # POST /consultas
  # POST /consultas.xml
  def create
    @consulta = Consulta.create(params[:consulta])
    respond_to do |format|
      if @consulta.save
        flash[:notice] = 'Se ha creado un nuevo registro'
        format.html { redirect_to pacientes_path(@consulta.paciente_id)  }
        format.js
        #format.xml  { render :xml => @consulta, :status => :created, :location => @consulta }
      else
        format.html { render :action => "new" }
        #format.xml  { render :xml => @consulta.errors, :status => :unprocessable_entity }
      end
    end
  end


  # PUT /consultas/1
  # PUT /consultas/1.xml
  def update
    @consulta = Consulta.find(params[:id])
    respond_to do |format|
      if @consulta.update_attributes(params[:consulta])
        flash[:notice] = 'Los datos clínicos fueron actualizados.'
        format.html { redirect_to(@consulta) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @consulta.errors, :status => :unprocessable_entity }
      end
    end
  end
  

  
  # DELETE /consultas/1
  # DELETE /consultas/1.xml
  def destroy
    @consulta = Consulta.find(params[:id])
    paciente_id=@consulta.paciente_id
    @consulta.destroy

    respond_to do |format|
      format.html { redirect_to :controller => 'pacientes',:action => 'show',:id => paciente_id}
      #format.xml  { head :ok }
    end
  end

end
