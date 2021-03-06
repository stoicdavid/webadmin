

class LabController < ApplicationController
  before_filter :login_required
  
  def index
    #if @cons = Consulta.find_all_by_doctor_id(nil)
    #  for doc in @cons
    #    doc.destroy
    #  end
    #end
    
  #  if params[:search] != nil
  #    values={}
  #    nombre = "%#{params[:search]}%".split(/\s+/)
  #    nombre.each { |x| values[:str] = x}
  #    paciente = Paciente.find(:all,
  #     :conditions => ['nombre LIKE :str or app_pat LIKE :str or app_mat LIKE :str',values ])
  #    @consultas = Consulta.find_all_by_paciente_id(paciente.each { |x| x.id})
  #  else
  #    @consultas = Consulta.find(:all)
  #  end  
  #  respond_to do |format|
  #    format.html # index.html.erb

    #end
    @citas = Cita.find(:all)
    @dates = @citas.collect { |p| p.fecha_hora.strftime('%d-%m-%Y') }
    @consultas_hoy = Cita.find_all_by_fecha_hora(Time.now.beginning_of_day + 5.hour...Time.now.end_of_day + 5.hour,:order => "fecha_hora ASC",:conditions => ['status <> ?','cancelada'])
    @confirma_hoy = Cita.find_all_by_fecha_hora(0.day.since(Time.now.beginning_of_day + 5.hour)...1.day.since(Time.now.end_of_day + 5.hour), :conditions =>
    {:status => ['activa','reprogramada']},:order => "fecha_hora ASC")
    @sin_confirma = Cita.find_all_by_fecha_hora(Time.now.beginning_of_week...Time.now.end_of_week, 
    :conditions => {:status => ['activa','reprogramada']},:order => "fecha_hora ASC")
  end
  
  def debug
    flash[:notice] = "Prueba de creacion"
    redirect_to :action => 'show', :controller => 'pacientes'
  end
  

  
  def borra_cita
    cita=Cita.find(params[:id])
    cita.update_attributes(:fecha_hora => nil,:status => 'Sin Cita',:cubiculo =>nil  )
    redirect_to :action => 'crea_cita', :id => cita.id
  end

  def muestra_tab
    @drag = params[:locals][:drag]
    @paciente=params[:id]
    consulta=Consulta.find(params[:locals][:consulta_id])
    operation=Operation.create(:cita_id => 0,:tipo_id => consulta.estudio_id)
    @cita=Cita.create(:paciente_id => params[:id],:fecha_hora => params[:locals][:fecha_hora],:status => 'Activa',
    :cubiculo => params[:locals][:cubiculo],:operation_id => operation.id)
    @cita.save
    operation.save
    operation.update_attributes(:cita_id => @cita.id)
    consulta.update_attributes(:cita_id => @cita.id)
    render :action => 'muestra',:id => @paciente
  end
  
  
  
  def show_celda
        @drag = params[:id]
        @paciente=params[:locals][:paciente]
        
        render :action => 'muestra', :object => @drag, :id => @paciente
  end

  def show_horario
    @cubiculos = Horario.find_cubiculos
    @time_windows = Array.new
    horario = Horario.find(:all, :order => 'cubiculo' )
    horario.each { |h| 
      tw = TimeWindow.new(h.horas)
      @time_windows << tw.rules
    }
  end

  def new_regla

    @date_from = Time.now
    @date_to = Time.now   
    @horario=Horario.find_by_cubiculo(params[:id])
  end

  def add_regla
    horario = Horario.find_by_cubiculo(params[:cubiculo])
    new_rule = ""
    @Dias.each do |dia|
      day = @Days[params[:checkbox][dia].to_i]
      new_rule += if day then day + " " else "" end
    end

    new_rule += "#{params[:date][:from_hour]}#{params[:date][:from_minutes]}-"
    new_rule += "#{params[:date][:to_hour]}#{params[:date][:to_minutes]}"
    horario.horas= horario.horas + " " + new_rule + ";"
    horario.save
    redirect_to :action => 'show_horario'
  end

  def edit_regla
    @horario=Horario.find_by_cubiculo(params[:id])
    @checkbox = Hash.new
    rule = params[:rule]["rule"]
    tw = TimeWindow.new rule
    tw.rules[0][:days].split(" ").each do |day|
      @checkbox[day] = true
    end
    from = Hash.new
    to = Hash.new    
    from[:hour] =  tw.ranges[0][0].to_s.slice(1..2).to_i
    to[:hour] = tw.ranges[0][1].to_s.slice(1..2).to_i
    from[:min] =  tw.ranges[0][0].to_s.slice(3..4).to_i
    to[:min] = tw.ranges[0][1].to_s.slice(3..4).to_i
    @date_from =  Time.local(2000,"jan",1,from[:hour],from[:min],1)
    @date_to = Time.local(2000,"jan",1,to[:hour],to[:min],1)
    @rule = rule
  end

  def update_regla
    horario = Horario.find_by_cubiculo(params[:cubiculo])
    new_rule = ""
    @Dias.each do |dia|
      day = @Days[params[:checkbox][dia].to_i]
      new_rule += if day then day + " " else "" end
    end

    new_rule += "#{params[:date][:from_hour]}#{params[:date][:from_minutes]}-"
    new_rule += "#{params[:date][:to_hour]}#{params[:date][:to_minutes]}"
    #horario.horas= horario.horas + " " + new_rule + ";"
    horario.horas= horario.horas.sub(params[:rule], new_rule)
    horario.save
    redirect_to :action => 'show_horario'
  end


  def delete_regla
    rule = params[:rule]
    horario = Horario.find_by_cubiculo(params[:id])
    horario.horas= horario.horas.sub(rule[:rule]+";", "")
    horario.save
    redirect_to :action => 'show_horario'
  end
  
  def realizar_busqueda
    d=Time.parse(params[:fecha_cita])
    @horarios = Array.new
    if cita = Cita.find_by_fecha_hora(d,:conditions => ['cubiculo = ?',params[:cubiculo]])

     cita.fecha_hora.to_s(:short) == d.to_s(:short) 
        render :action => 'busqueda'
      else
        hor = Horario.find(:all)        


        for h in hor
          if TimeWindow.new(h.horas).include? d or h.cubiculo.eql? params[:cubiculo].to_i
            @horarios << h
          end
        end
        render :update do |page|
          page['resultados'].replace_html :partial => 'horario_busqueda', :object => @horarios,
          :locals => {:fecha_cita  => d, :pac_id => params[:paciente]}
        end
           
    end
  end

  def asigna_cita

      
    fecha = params[:dia] + " " + params[:date][:hour] + ":" + params[:date][:minute]
    fecha_cita = Time.parse(fecha)
    if cita = Cita.find_by_fecha_hora(fecha_cita.gmtime,:conditions => ['cubiculo = ?',params[:cita][:cubiculo]])
      render :update do |page|
        page.insert_html :bottom, 'citas', 'Ya existe una cita asignada en ese horario'
      end
    else
      consulta=Consulta.find(params[:consulta])
      operation=Operation.create(:cita_id => 0,:tipo_id => consulta.estudio_id)
      @cita=Cita.create(:paciente_id => params[:paciente],:fecha_hora => fecha_cita,
      :cubiculo => params[:cita][:cubiculo],:operation_id => operation.id)
      @cita.save
      operation.save
      operation.update_attributes(:cita_id => @cita.id)
      consulta.update_attributes(:cita_id => @cita.id)
      render :update do |page|
        page['resultados'].replace_html :partial => 'cita_creada', :id => params[:paciente]
        page['resultados'].visual_effect :highlight, :duration => 5
        page['tablas'].toggle
      end
    end
  end
  
  def envia_info 
  consulta = Consulta.find(params[:id])
  @doctor = consulta.doctor
  @paciente = consulta.paciente
  @estudio = Estudio.find(consulta.estudio_id)
  @fecha_cita = consulta.cita.fecha_hora
  email = NeuroMailer.create_informa_paciente(@paciente,@estudio,@fecha_cita,@doctor) 
  #email.set_content_type("text/html")
  NeuroMailer.deliver(email) 
  #consulta.cita.confirmar
  #consulta.cita.save
  flash[:notice] = "Se ha enviado el correo a #{@paciente.correo}"
  redirect_to @paciente
end

  def cancelar
    cita=Consulta.find(params[:id_cons]).cita
    cita.cancelar!
    flash[:notice] = "La cita ha sido cancelada"
    redirect_to :controller => 'pacientes',:action => 'show', :id => params[:id]

  end
  
  def update_calendario
    @mes_actual = Time.parse(params[:id])
    @mes_anterior = 1.month.ago(@mes_actual)
    @mes_sig = 1.month.since(@mes_actual)
    @citas = Cita.find_all_by_fecha_hora(@mes_actual.beginning_of_month...@mes_actual.end_of_month)
    @dates = @citas.collect { |p| p.fecha_hora.strftime('%d-%m-%Y') }    
    @paciente = Paciente.find(params[:paciente_id])

    @citas = Cita.find_all_by_fecha_hora(@mes_actual.beginning_of_month...@mes_actual.end_of_month)
    @dates = @citas.collect { |p| p.fecha_hora.strftime('%d-%m-%Y') }
    render :update do |page|
      page['calendario'].replace_html :partial => "calendar", :locals => {:id_cons => params[:id_cons]}
      page['calendario'].visual_effect 'appear', :duration => 1.3

      
    end        
  end

  def list_horarios
    @cubiculos = Cita.find_all_by_fecha_hora(params[:fec_cita],:order => 'cubiculo')
    render :update do |page|
      page['resultados'].replace_html :partial => 'horario', :object => @cubiculos, 
      :locals => {:paciente_id => params[:id]}
    end
  end

  def reprogramar
    
    if params[:id] == 'anterior'
      cita = Consulta.find(params[:id_cons],:include => :cita).cita
      cita.reprogramar!
      flash[:notice] = "La cita ha sido reprogramada en el horario antes establecido"
      redirect_to :controller => 'pacientes',:action => 'show', :id => cita.paciente_id      
    else    
      @mes_actual = Time.now
      @mes_anterior = 1.month.ago(@mes_actual)
      @mes_sig = 1.month.since(@mes_actual)
      @cita = Consulta.find(params[:id_cons],:include => :cita).cita
      @paciente = Paciente.find(@cita.paciente_id)
      @citas = Cita.find_all_by_fecha_hora(@mes_actual.beginning_of_month...@mes_actual.end_of_month)
      @dates = @citas.collect { |p| p.fecha_hora.strftime('%d-%m-%Y') }
      render :partial => 'crea_cita', :id => @paciente.id, :layout => "lab",:object => @citas
    end
  end
  
  def actualiza_cita
    fecha = params[:dia] + " " + params[:date][:hour] + ":" + params[:date][:minute]
    fecha_cita = Time.parse(fecha)
    if cita = Cita.find_by_fecha_hora(fecha_cita.gmtime,:conditions => ['cubiculo = ?',params[:cita][:cubiculo]])
      render :update do |page|
        page.insert_html :bottom, 'citas', 'Ya existe una cita asignada en ese horario'
      end
    else
      consulta=Consulta.find(params[:consulta])
      @cita=Cita.update(params[:cita_id],:paciente_id => params[:paciente],:fecha_hora => fecha_cita,
      :cubiculo => params[:cita][:cubiculo])
      @cita.reprogramar!
      #flash[:notice] = 'La cita fue actualizada exitosamente'
      #redirect_to :action => 'index',:controller => "admin"
      render :update do |page|
        page['resultados'].replace_html :partial => 'cita_creada', :id => params[:paciente]
        page['resultados'].visual_effect :highlight, :duration => 5
        page['tablas'].toggle
      end
    end
    
  end



  def crea_cita
    @mes_actual = Time.now
    @mes_anterior = 1.month.ago(@mes_actual)
    @mes_sig = 1.month.since(@mes_actual)
      
    @paciente = Paciente.find(params[:id])
    #@cita = Cita.create(:paciente_id => consulta.paciente_id,:status => 'Activa',:operation_id => 0)
    #consulta.update_attributes(:cita_id => @cita.id)
    #operation = Operation.create(:cita_id => consulta.cita_id,:tipo => "value", )
    #@cita.update_attributes(:operation_id => operation.id)
    #	<%= render :partial => 'consultas/listas', :collection => @cons = @paciente.consultas, :id => @paciente.id %>
    @citas = Cita.find_all_by_fecha_hora(@mes_actual.beginning_of_month...@mes_actual.end_of_month)
    @dates = @citas.collect { |p| p.fecha_hora.strftime('%d-%m-%Y') }
    render :partial => 'crea_cita', :id => @paciente.id, :layout => "lab"
  end
  
  def confirmar
    cit = Consulta.find(params[:id_cons],:include => :cita).cita
    redirect_to :controller => "citas", :id => cit.id, :action  => 'confirma'
  end
  
  def concluir_estudio
    cit = Consulta.find(params[:id_cons],:include => :cita).cita
    operacion = Operation.find_by_cita_id(cit.id)
    redirect_to :controller => "operations", :id => operacion.id, :action  => 'edit'
  end
  
  def interpretar
    cit = Consulta.find(params[:id_cons],:include => :cita).cita
    redirect_to :controller => "operations", :action  => 'edita',:id => cit.operation.id
  end
  
  def generar_id
    cit = Consulta.find(params[:id_cons],:include => :cita).cita
    @operacion = Operation.find_by_cita_id(cit.id)
    @operacion.genera_id
    cit.generar_id! 
    flash[:notice] = "El ID ha sido generado"   
    redirect_to :controller => "pacientes", :id => params[:id], :action  => 'show'
  end
  
  def pagar_estudio
    redirect_to :controller => 'operations',:action => "genera_orden", :id => Consulta.find(params[:id_cons],:include => :cita).cita.operation.id
  end

  def cancelar_pago
    pago = Pago.find(Consulta.find(params[:id_cons]).cita.operation.pago_id)
    pago.destroy
    Consulta.find(params[:id_cons]).cita.cancelar_pago_pago!
    flash[:notice] = "El pago ha sido cancelado"   
    redirect_to :controller => "pacientes", :id => params[:id], :action  => 'show'
  end
  
  #def vista_dia
  #  @citas = Cita.find_all_by_fecha_hora(Time.now.beginning_of_day...Time.now.end_of_day)
  #  @cita_horas = @citas.group_by { |t| t.fecha_hora.hour}
  #  render :partial => 'tabla_dia',:collection => @citas ,:id => params[:id]
  #end

  def vista_semana
    @consultas = Consulta.find_all_by_fecha_consulta(Time.now.beginning_of_week...Time.now.end_of_week)
    @consulta_dias = @consultas.group_by { |t| t.fecha_consulta.beginning_of_day}
    render :partial => "vista_semana" , :layout =>  "lab"
  end
  
  def vista_mes
    @consultas = Consulta.find_all_by_fecha_consulta(Time.now.beginning_of_month...Time.now.end_of_month)
    @consulta_dias = @consultas.group_by { |t| t.fecha_consulta.beginning_of_day}    
    render :partial => "vista_mes" , :layout =>  "lab"
  end
  
def lista_honorarios
  @doctor = Doctor.find_by_id(params[:id])
  
  render :partial => "consultas", :layout =>  "lab", :id => @doctor.id
end  

def pago_dia
  @pagos = Array.new
  @consultas = Consulta.find_all_by_doctor_id(params[:id])
  @consultas.each {|x|
    if pago = x.cita.operation.generate.pago
    @pagos << pago
    end}
  @cons_pagos = @pagos.group_by { |t| t.created_at.hour}
  render :partial => "pago_dia" , :layout =>  "lab"
  #render :update do |page|
  #  page['honorarios'].replace_html :partial => "pago_dia", :object => @pagos
  #end
end

def pago_semana
  @pagos = Array.new
  @consultas = Consulta.find_all_by_doctor_id(params[:id])
  @consultas.each {|x|
      unless x.cita.operation.nil? 
        if x.cita.operation.pago_id != nil
          pago_id=x.cita.operation.pago_id
          pago = Pago.find(pago_id) 
              @pagos << pago
        end                 
    end}
    
  @cons_pagos = @pagos.group_by { |t| t.created_at.beginning_of_day}
  render :partial => "pago_semana" , :layout =>  "lab"
#  render :update do |page|
 #   page['honorarios'].replace_html :partial => "pago_semana", :object => @pagos
#  end
end

def pago_mes
  @pagos = Array.new
  n=0
  n=1 if params[:flag]
  @consultas = Consulta.find(:all,:conditions => ['doctor_id = ?',params[:id]])  
  @consultas.each {|x|
    if !x.cita.nil?
      if x.cita.status_pago == 'estudio_pagado'
          pago_id = x.cita.operation.pago_id
          pago = Pago.find(pago_id) 
          @pagos << pago
      end
    end
      }
  @cons_pagos = @pagos.group_by { |t| t.created_at.beginning_of_month}    
  render :partial => "pago_mes" , :layout =>  "lab"
  #render :update do |page|
  #  page['honorarios'].replace_html :partial => "pago_mes", :object => @pagos
  #end
end


end

