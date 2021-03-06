class OperationsController < ApplicationController
  # GET /operations
  # GET /operations.xml
  before_filter :login_required
  def index
    @operations = Operation.find(:all,:order => "indice_estudio ASC")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @operations }
    end
  end

  # GET /operations/1
  # GET /operations/1.xml
  def show
    @operation = Operation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @operation }
    end
  end

  # GET /operations/new
  # GET /operations/new.xml
  def new
    @operation = Operation.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @operation }
    end
  end

  # GET /operations/1/edit
  def edit
    @operation = Operation.find(params[:id])
  end

  # POST /operations
  # POST /operations.xml
  def create
    @operation = Operation.new(params[:operation])

    respond_to do |format|
      if @operation.save
        flash[:notice] = 'Operation was successfully created.'
        format.html { redirect_to(@operation) }
        format.xml  { render :xml => @operation, :status => :created, :location => @operation }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @operation.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /operations/1
  # PUT /operations/1.xml
  def update
    @operation = Operation.find(params[:id])
    cita = Cita.find(@operation.cita_id)
    respond_to do |format|
      if @operation.update_attributes(params[:operation])
        if cita.status == 'estudio_en_proceso'
          cita.concluir_estudio!
        elsif cita.status =="estudio_exitoso"
          cita.interpretar!
        end
        flash[:notice] = 'El estudio ha sido actualizado'
        format.html { redirect_to :controller => 'pacientes',:action => 'show',:id => cita.paciente_id  }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @operation.errors, :status => :unprocessable_entity }
      end
    end
  end

  def genera_orden


    redirect_to :controller => "pagos", :id => params[:id],  :action => 'new' 
  end

  def h_llegada
    op = Operation.find(params[:id])
    op.hora_llegada= Time.now
    op.save
    redirect_to :controller  => "operations", :id => params[:id], :action => "edit"
  end
  
  def ini_con
    op = Operation.find(params[:id])
    op.ini_conexion= Time.now
    op.save
    redirect_to :controller  => "operations", :id => params[:id], :action => "edit"
  end
  
  def fin_con
    op = Operation.find(params[:id])
    op.fin_conexion= Time.now
    op.save
    redirect_to :controller  => "operations", :id => params[:id], :action => "edit"
  end
  
  def ini_est
    op = Operation.find(params[:id])
    op.ini_estudio= Time.now
    op.save
    redirect_to :controller  => "operations", :id => params[:id], :action => "edit"
  end
  
  def fin_est
    op = Operation.find(params[:id])
    op.fin_estudio= Time.now
    op.save
    cita = op.cita
    cita.status = 'Estudio Realizado'
    cita.save
    redirect_to :controller  => "operations", :id => params[:id], :action => "edit"
  end
  
  def edita
    @operation = Operation.find(params[:id])
  end


  # DELETE /operations/1
  # DELETE /operations/1.xml
  def destroy
    @operation = Operation.find(params[:id])
    @operation.destroy

    respond_to do |format|
      format.html { redirect_to(operations_url) }
      format.xml  { head :ok }
    end
  end
  
  
end
