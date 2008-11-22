class ReferenciasController < ApplicationController
  # GET /referencias
  # GET /referencias.xml
  def index
    usuario = usuario=Usuario.find_by_id(session[:usuario_id])
    if usuario.doctor_id.nil?
     doctor_id = ""
    else
     doctor_id = "doctor_id = #{usuario.doctor_id}"
    end

    @referencias = Referencia.find(:all,:conditions => [doctor_id])

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @referencias }
    end
  end

  # GET /referencias/1
  # GET /referencias/1.xml
  def show
    @referencia = Referencia.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @referencia }
    end
  end

  # GET /referencias/new
  # GET /referencias/new.xml
  def new
    @referencia = Referencia.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @referencia }
    end
  end

  # GET /referencias/1/edit
  def edit
    @referencia = Referencia.find(params[:id])
  end

  # POST /referencias
  # POST /referencias.xml
  def create
    @referencia = Referencia.new(params[:referencia])
    usuario = usuario=Usuario.find_by_id(session[:usuario_id])
    @referencia.doctor_id = usuario.doctor_id unless usuario.doctor_id.nil?
    
    respond_to do |format|
      if @referencia.save
        flash[:notice] = 'Se ha agregado una nueva referencia'
        format.html { redirect_to(@referencia) }
        format.xml  { render :xml => @referencia, :status => :created, :location => @referencia }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @referencia.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /referencias/1
  # PUT /referencias/1.xml
  def update
    @referencia = Referencia.find(params[:id])

    respond_to do |format|
      if @referencia.update_attributes(params[:referencia])
        flash[:notice] = 'La referencia fue actualizada'
        format.html { redirect_to(@referencia) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @referencia.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /referencias/1
  # DELETE /referencias/1.xml
  def destroy
    @referencia = Referencia.find(params[:id])
    @referencia.destroy

    respond_to do |format|
      format.html { redirect_to(referencias_url) }
      format.xml  { head :ok }
    end
  end
end
