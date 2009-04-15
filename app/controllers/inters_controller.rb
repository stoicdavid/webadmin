class IntersController < ApplicationController
  # GET /inters
  # GET /inters.xml
  
  def imprime
    prawnto :prawn => {
                   :left_margin => 60,
                   :right_margin => 20,
                   :top_margin => 80,
                   :bottom_margin => 20 }
     @paciente = Paciente.find(params[:paciente_id])                
     @consulta = Consulta.find(params[:id])
     @inter = @consulta.inter unless @consulta.inter.nil?
     @estudio = Operation.find_by_cita_id(@consulta.cita.id).ref_estudio
      respond_to do |format|
         format.pdf {render :layout => false }
     end
    
  end
  
  
  def index
    @consultas = Consulta.paginate(:all,:page => params[:page],:per_page => 20 )
    @inters = Array.new
    @consultas.each {|consulta| 
      @inters << consulta if consulta.inter.nil?
      }

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @inters }
    end
  end

  # GET /inters/1
  # GET /inters/1.xml
  def show
    @inter = Inter.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @inter }
    end
  end

  # GET /inters/new
  # GET /inters/new.xml
  def new
    @consulta = Consulta.find(params[:id])
    @inter = @consulta.build_inter

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @inter }
    end
  end

  # GET /inters/1/edit
  def edit
    @inter = Inter.find(params[:id])
    @consulta = @inter.consulta
  end

  # POST /inters
  # POST /inters.xml
  def create
    @inter = Inter.new(params[:inter])
    
    respond_to do |format|
      if @inter.save
        cit = Consulta.find(params[:inter][:consulta_id],:include => :cita).cita
        cit.interpretar!        
        flash[:notice] = 'La interpretación se agregó exitosamente'
        format.html { redirect_to(@inter) }
        format.xml  { render :xml => @inter, :status => :created, :location => @inter }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @inter.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /inters/1
  # PUT /inters/1.xml
  def update
    @inter = Inter.find(params[:id])

    respond_to do |format|
      if @inter.update_attributes(params[:inter])

        flash[:notice] = 'La interpretación se actualizó correctamente.'
        format.html { redirect_to(@inter) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @inter.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /inters/1
  # DELETE /inters/1.xml
  def destroy
    @inter = Inter.find(params[:id])
    @inter.destroy

    respond_to do |format|
      format.html { redirect_to(inters_url) }
      format.xml  { head :ok }
    end
  end
end
