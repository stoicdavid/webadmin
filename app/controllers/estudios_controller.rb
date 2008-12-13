class EstudiosController < ApplicationController
  # GET /estudios
  # GET /estudios.xml
  def index
    @estudios = Estudio.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @estudios }
    end
  end

  # GET /estudios/1
  # GET /estudios/1.xml
  def show
    @estudio = Estudio.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @estudio }
    end
  end

  # GET /estudios/new
  # GET /estudios/new.xml
  def new
    @estudio = Estudio.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @estudio }
    end
  end

  # GET /estudios/1/edit
  def edit
    @estudio = Estudio.find(params[:id])
  end

  # POST /estudios
  # POST /estudios.xml
  def create
    @estudio = Estudio.new(params[:estudio])
    
    respond_to do |format|
      if @estudio.save
        flash[:notice] = "Estudio #{@estudio.nombre} fue creado exitosamente."
        format.html { redirect_to(:action => :index ) }
        format.xml  { render :xml => @estudio, :status => :created, :location => @estudio }
      else
        format.html { redirect_to :action => "new",:id => params[:estudio][:doctor_id] } #:locals => {:id => params[:id]}
        format.xml  { render :xml => @estudio.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /estudios/1
  # PUT /estudios/1.xml
  def update
    @estudio = Estudio.find(params[:id])

    respond_to do |format|
      if @estudio.update_attributes(params[:estudio])
        flash[:notice] = "Estudio #{@estudio.nombre} fue actualizado."
        format.html { redirect_to(:controller => "doctors",:action => "show",:id => @estudio.doctor_id) }
        format.xml  { head :ok }
      else
        format.html { redirect_to :action => "edit" }
        format.xml  { render :xml => @estudio.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /estudios/1
  # DELETE /estudios/1.xml
  def destroy
    @estudio = Estudio.find(params[:id])
    @estudio.destroy

    respond_to do |format|
      format.html { redirect_to(estudios_url) }
      format.xml  { head :ok }
    end
  end
  
end
