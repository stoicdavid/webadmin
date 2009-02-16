class Doctor < ActiveRecord::Base
  has_one :usuario
  has_one :especialidad
  has_many :consultas
  has_many :pacientes, :through => :consultas
  
  file_column :imagen, :magick => { :geometry => "100x100" }
  
  validates_presence_of :nombre, :app_pat, :app_mat, :correo, :on => :create, :message => " no puede ser vacio"
  validates_uniqueness_of :rfc_virtual, :on => :create, :message => "^Doctor capturado anteriormente"
  
  GENERO = [ 
  # Displayed stored in db 
  [ "Masculino", "m" ], 
  [ "Femenino", "f" ]
  ]
  
  
  #validates_numericality_of :cp
  def self.find_all
    find(:all).collect { |p| [p.nombre_completo, p.id] }
  end
  
   def genera_rfc
     rfc =  self.app_pat.first.capitalize unless self.app_pat.first.nil?
     rfc += self.app_pat.scan(/[aeiou]/).first.capitalize unless self.app_pat.scan(/[aeiou]/).first.nil?
     rfc += self.app_mat.first.capitalize unless self.app_mat.first.nil? 
     rfc += self.nombre.first.capitalize unless self.nombre.first.nil? 
     self.rfc_virtual = rfc

  end
  
    def especialidad_atributos=(atributos)
      #atributos.each do |a|
        build_especialidad(atributos)
     #end
    end

    def nombre_completo
      nom = self.nombre
      nom += self.nombre_2
      nom += ' ' + self.app_pat
      if self.app_mat.scan(/x/i).empty?
        nom += ' ' + self.app_mat
      end
      nom
    end
  
  
  def codigo
     cod = ""
     if self.cp.to_s.length == 4
       cod+='0' + self.cp.to_s
     else 
       cod = self.cp.to_s
     end
     cod
   end
  
  def direccion_completa
    d = self.calle unless self.calle.nil?
    d += ' ' + self.colonia unless self.colonia.nil?
    d += ' ' + self.estado unless self.estado.nil?
    d += ' ' + self.codigo
    d
  end
  
  def direccion_fiscal_completa
      d = self.calle_fis unless self.calle_fis.nil?
      d += ' ' + self.num_ext_fis unless self.num_ext_fis.nil?
      d += ' ' + self.num_int_fis unless self.num_int_fis.nil?
      d += ' ' + self.colonia_fis unless self.colonia_fis.nil?
      d += ' ' + self.del_mun unless self.del_mun.nil?
      d += ' ' + self.estado_fis unless self.estado_fis.nil?
      d += ' '+ self.codigo_fiscal
      d
  end
  
end
