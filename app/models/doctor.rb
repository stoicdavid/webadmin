class Doctor < ActiveRecord::Base
  has_one :usuario
  has_one :specialization
  has_many :consultas
  has_many :pacientes, :through => :consultas
  
  file_column :imagen, :magick => { :geometry => "100x100" }
  
  validates_presence_of :nombre, :app_pat, :app_mat, :on => :create, :message => " no puede ser vacio"
  validates_presence_of :especialidad => {:doctor  => :especialidads_id}, :on => :create, :message => "can't be blank"
  #validates_inclusion_of :especialidad => {:doctor  => :especialidads_id} , :in => Especialidad.find(:all).map { |esp| esp.id }
  #validates_numericality_of :cp
  def self.find_all
    find(:all).collect { |p| [p.nombre_completo, p.id] }
  end
  
  def nombre_completo
  	self.nombre + " " + self.nombre_2 + " " + self.app_pat + " " + self.app_mat
  end
  
  def direccion_completa
  	self.calle + " " + self.colonia + " " + self.estado + " " + self.cp.to_s
  end
  
end
