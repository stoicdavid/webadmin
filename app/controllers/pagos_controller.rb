class BigDecimal
  def round_to(x)
    (self * 10**x).round.to_f / 10**x
  end

  def ceil_to(x)
    (self * 10**x).ceil.to_f / 10**x
  end

  def floor_to(x)
    (self * 10**x).floor.to_f / 10**x
  end
end

class PagosController < ApplicationController
  before_filter :login_required
  # GET /pagos
  # GET /pagos.xml
  def index
    @pagos = Pago.find(:all)
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pagos }
    end
  end

  # GET /pagos/1
  # GET /pagos/1.xml
  def show
    
    @pago = Pago.find(params[:id])
    if params[:paciente_id] == nil
      @paciente=Operation.find_by_pago_id(params[:id]).cita.consulta.paciente
    else
      @paciente=Paciente.find(params[:paciente_id])
    end
    if params[:paciente_id] == nil
      @operation=Operation.find_by_pago_id(params[:id])
    else
      @operation = Operation.find(params[:operation_id])
    end
    @estudio = Estudio.find(@operation.tipo_id)
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @pago }
    end
  end
  
  def imprime
    
      prawnto :prawn => {
                    :left_margin => 30,
                    :right_margin => 20,
                    :top_margin => 89,
                    :bottom_margin => 36 }


      @pago = Pago.find(params[:id])
      @paciente=Paciente.find(params[:paciente_id])
      if !@paciente.rfc.nil?
        @rfc = @paciente.rfc
      else
        @rfc=""
      end
      @operation = Operation.find(params[:operation_id])
      @estudio = Estudio.find(@operation.tipo_id)
      @fecha = l Time.now, :format => '%d - %B - %Y'
      if @pago.descuento != "0"
        @descuento = "Descuento #{@estudio.descuento_porcentaje}"
        @importe_des = "-" + @pago.descuento_f
      else
        @descuento = ''
        @importe_des = ''
      end
      if @descuento == ""
        @subtotal = @pago.precio.to_f - @pago.descuento.to_f
      else
        @subtotal = @pago.precio.to_f - @pago.descuento.to_f
      end
      @iva = @subtotal* 0.15

    respond_to do |format|
      #format.html # show.html.erb
      #format.xml  { render :xml => @pago }
      format.pdf {render :layout => false }
    end
  end
  

  # GET /pagos/new
  # GET /pagos/new.xml
  def new
    
    @pago = Pago.new
    @operation = Operation.find(params[:id])
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @pago }
    end
  end

  # GET /pagos/1/edit
  def edit
    @pago = Pago.find(params[:id])
  end

  # POST /pagos
  # POST /pagos.xml
  def create

    params[:descuento_b] == "1" ? @descuento = params[:pago][:precio].to_f*Estudio.find(params[:pago][:tipo_id]).descuento : @descuento = 0
    
    subtotal = params[:pago][:precio].to_f - @descuento
    iva = subtotal * 0.15
    total = subtotal + iva
    @pago = Pago.create(
      :forma_pago => params[:pago][:forma_pago],:factura => params[:pago][:factura],
      :folio_factura => params[:pago][:folio_factura],:total => total ,:precio => params[:pago][:precio],
      :descuento => @descuento)
    
    respond_to do |format|
      if @pago.save
        operation = Operation.find(params[:pago][:operation_id])
        operation.update_attributes(:pago_id => @pago.id)
        cita = Cita.find_by_operation_id(params[:pago][:operation_id])
        cita.status = 'Pagada'
        cita.save
        flash[:notice] = 'Pago was successfully created.'
        format.html { redirect_to(:action => 'show', :id => @pago.id ,:paciente_id => params[:pago][:paciente_id],
          :operation_id => params[:pago][:operation_id]) }
        format.xml  { render :xml => @pago, :status => :created, :location => @pago }

      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @pago.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /pagos/1
  # PUT /pagos/1.xml
  def update
    @pago = Pago.find(params[:id])

    respond_to do |format|
      if @pago.update_attributes(params[:pago])
        flash[:notice] = 'Pago was successfully updated.'
        format.html { redirect_to(@pago) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @pago.errors, :status => :unprocessable_entity }
      end
    end
  end




  # DELETE /pagos/1
  # DELETE /pagos/1.xml
  def destroy
    @pago = Pago.find(params[:id])
    @pago.destroy
    
    respond_to do |format|
      format.html { redirect_to(pagos_url) }
      format.xml  { head :ok }
    end
  end
end
