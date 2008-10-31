class Operation < ActiveRecord::Base
  belongs_to :cita
  has_one :tipo, :dependent => :destroy
  has_one :pago, :dependent => :destroy
  
  def genera_id
    per = self.created_at.strftime('%m%y') +'mx'+self.id.to_s
    self.ref_estudio = per
    self.save
  end
  
end
