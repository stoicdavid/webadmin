

class LabController < ApplicationController



  
  def initialize
    
  
    
  @Days = {
    1 => "Mon",
    2 => "Tue",
    3 => "Wed",
    4 => "Thu",
    5 => "Fri"
  }
  
  @Day_n = {
    "Mon" => "1",
    "Tue" => "2",
    "Wed" => "3",
    "Thu" => "4",
    "Fri" => "5"
  }

  @Dias = ["Lunes", "Martes", "Miércoles", "Jueves", "Viernes"]
  @rgg = "Mon Tue Wed Thu Fri Sat"
  
  @Horas_impar = ["0700","0830","1000","1130","1300","1430","1600","1730","1900"]
  @Horas_par = ["0730","0900","10300","1200","1330","1500","1630","1800","1930"]
end
  
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
    @consultas_hoy = Cita.find_all_by_fecha_hora(Time.now.beginning_of_day...Time.now.end_of_day)
    @confirma_hoy = Cita.find_all_by_fecha_hora(1.day.ago(Time.now.beginning_of_day)...1.day.ago(Time.now.end_of_day), :conditions => ['status = ?','Activa'])
    @sin_confirma = Cita.find_all_by_status('Activa')
  end
  
  def debug
    flash[:notice] = "Prueba de creacion"
    redirect_to :action => 'show', :controller => 'pacientes'
  end
  
  def genera_id
    @operacion = Operation.find_by_cita_id(params[:id])
    @operacion.genera_id
    render :update do |page|
      page.replace_html 'ref_est', "La clave del estudio es #{@operacion.ref_estudio}"
    end
    
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

      
    fecha = params[:dia] + " " + params[:date][:hour_minute]
    fecha_cita = Time.parse(fecha)
    if cita = Cita.find_by_fecha_hora(fecha_cita.gmtime,:conditions => ['cubiculo = ?',params[:cita][:cubiculo]])
      render :update do |page|
        page.insert_html :bottom, 'citas', 'Ya existe una cita asignada en ese horario'
      end
    else
      consulta=Consulta.find(params[:consulta])
      operation=Operation.create(:cita_id => 0,:tipo_id => consulta.estudio_id)
      @cita=Cita.create(:paciente_id => params[:paciente],:fecha_hora => fecha_cita,:status => 'Activa',
      :cubiculo => params[:cita][:cubiculo],:operation_id => operation.id)
      @cita.save
      operation.save
      operation.update_attributes(:cita_id => @cita.id)
      consulta.update_attributes(:cita_id => @cita.id)
      render :update do |page|
        page['tablas'].replace_html :partial => 'cita_creada', :id => params[:paciente]
      end
    end
  end

  def cancela_cita
    cita=Consulta.find(params[:id_cons]).cita
    cita.destroy
    redirect_to :action => 'crea_cita', :id => params[:id],:id_cons => params[:id_cons]

  end


  def list_horarios
    @cubiculos = Cita.find_all_by_fecha_hora(params[:fec_cita],:order => 'cubiculo')
    render :update do |page|
      page['resultados'].replace_html :partial => 'horario', :object => @cubiculos, 
      :locals => {:paciente_id => params[:id]}
    end
  end

  def crea_cita
    
    paciente = Paciente.find(params[:id])
    #@cita = Cita.create(:paciente_id => consulta.paciente_id,:status => 'Activa',:operation_id => 0)
    #consulta.update_attributes(:cita_id => @cita.id)
    #operation = Operation.create(:cita_id => consulta.cita_id,:tipo => "value", )
    #@cita.update_attributes(:operation_id => operation.id)
    #	<%= render :partial => 'consultas/listas', :collection => @cons = @paciente.consultas, :id => @paciente.id %>
    @citas = Cita.find(:all)
    @dates = @citas.collect { |p| p.fecha_hora.strftime('%d-%m-%Y') }
    render :partial => 'crea_cita', :id => paciente.id, :layout => "lab"
  end
  
  def confirma_cita
    cit = Cita.find params[:id]
    cit.status = 'Confirmada'
    cit.save
    redirect_to :controller => "citas", :id => cit.id, :action  => 'confirma'
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
  render :partial => "pago_mes" , :layout =>  "lab"
  #render :update do |page|
  #  page['honorarios'].replace_html :partial => "pago_mes", :object => @pagos
  #end
end


end

