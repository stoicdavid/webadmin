class Operation < ActiveRecord::Base
  belongs_to :cita
  #has_one :tipo, :dependent => :destroy
  has_one :pago
  
  def genera_id
    l = Operation.find(:last,:conditions => ['ref_estudio IS NOT ?',nil])
    tmp = l.ref_estudio.slice(4,4).to_i + 1
    c_hist = ''
    c_mes = ''
    
    if tmp.to_s.length == 3
      c_hist = '0' + tmp.to_s
    elsif tmp.to_s.length == 2
      c_hist = '00' + tmp.to_s
    else
      c_hist = tmp.to_s
    end
    
    if Time.now.strftime('%m%y') == l.ref_estudio.slice(0,4)
      temp = l.ref_estudio.slice(10,2).to_i + 1
      if temp.to_s.length == 2
        c_mes+= temp.to_s
      else
        c_mes+= '0'+temp.to_s
      end
    else
      c_mes = '01'
    end
    
    per = Time.now.strftime('%m%y') + c_hist +'mx'+ c_mes
    self.ref_estudio = per
    self.save
  end
  
end
