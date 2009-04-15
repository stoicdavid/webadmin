class Paciente < ActiveRecord::Base
  has_many :consultas, :dependent => :delete_all
  has_many :doctors, :through => :consultas
  has_many :citas, :dependent => :delete_all
  has_many :operations, :through => :citas
  belongs_to :referencias

  @@per_page = 3
  GENERO = [ 
  # Displayed stored in db 
  [ "Masculino", "m" ], 
  [ "Femenino", "f" ]
  ]
  
  PAR = [ 
  # Displayed stored in db 
  [ "Mamá", "m" ], 
  [ "Papá", "p" ],
  ["El mismo","y"],
  [ "Otro", "o" ]
  ]
  
  validates_presence_of :nombre, :on => :create, :message => 
  "^El nombre no puede ser vacío"
  validates_presence_of :app_pat, :on => :create, :message => 
  "^El apellido paterno no puede ser vacío."
  validates_presence_of :app_mat, :on => :create, :message => 
  "^El apellido materno no puede ser vacío."
  validates_presence_of :fecha_nac, :on => :create, :message => 
  "^La fecha de nacimiento no puede ser vacía ( Si no cuenta con ella capturar 01-01-1900)"
  validates_presence_of :nombre_contacto, :on => :create, :message => 
  "^Debes agregar un contacto"
  validates_format_of :correo, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :message => "^El formato del correo no es válido"

  
  
  validates_inclusion_of :genero, :in => GENERO.map {|disp, value| value},:message => "^Debes seleccionar un género."
  validates_inclusion_of :parentezco, :in => PAR.map {|disp, value| value},:message => "^Debes seleccionar un parentezco."
  validates_uniqueness_of :rfc_pac, :on => :create, :message => "^Paciente capturado anteriormente."
  
  def consulta_atributos=(atributos)
#    atributos.each do |a|
      consultas.build(atributos)
 #   end
  end

  
  def nombres
    [nombre,nombre_2].join(' ')
  end
  
  def genera_rfc
    rfc =  self.app_pat.first.capitalize unless self.app_pat.first.nil?
    rfc += self.app_pat.scan(/[aeiou]/).first.capitalize unless self.app_pat.scan(/[aeiou]/).first.nil?
    rfc += self.app_mat.first.capitalize unless self.app_mat.first.nil? 
    rfc += self.nombre.first.capitalize unless self.nombre.first.nil? 
    rfc += self.fecha_nac.strftime('%y%m%d') unless self.fecha_nac.nil?
    self.rfc_pac = rfc

 end
  
  
  def nombres=(nombre)
    split = nombre.split(' ', 2)
    if split.first!=split.last
      self.nombre = split.first
      self.nombre_2 = split.last
    else
      self.nombre = split.first
    end
  end
  
  def lista_pacientes
    @paciente = self.find(:all)
  end
  
  def edad(edad_p)
      now = edad_p
      now.year - self.fecha_nac.year - (self.fecha_nac.to_time.change(:year => now.year) > now ? 1 : 0)
  end
  
  
  def edad_meses(edad_p)
      now = edad_p
      actual = self.fecha_nac.to_time.change(:year => now.year)
      actual > now ? 12 - (actual.month - now.month)  : (now.month - actual.month)
  end
  
  def nombre_medio
    self.nombre + " " + self.app_pat
  end

  def nombres
    nombre = self.nombre
    if !self.nombre_2.nil?
      nombre += ' ' + self.nombre_2
    end
    nombre
  end

  def nombre_completo
    nom = nombres
    nom += ' ' + self.app_pat
    if self.app_mat.scan(/x/i).empty?
      nom += ' ' + self.app_mat
    end
    nom
  end
  
  def codigo_fiscal
    cod = ""
    if self.cp_fis.to_s.length == 4
      cod+='0' + self.cp_fis.to_s
    else 
      cod = self.cp_fis.to_s
    end
    cod
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

       
  def domicilio_completo
    d = self.calle_dom unless self.calle_dom.nil?
    d += ' ' + self.num_ext_dom unless self.num_ext_dom.nil?
    d += ' ' + self.num_int_dom unless self.num_int_dom.nil?
    d += ' ' + self.colonia_dom unless self.colonia_dom.nil?
    d += ' ' + self.del_mun_dom unless self.del_mun_dom.nil?
    d += ' ' +self.estado_dom unless self.estado_dom.nil?
    d
    
  end
  
  def tel_cel
    cel = ""
    cel = self.celular unless self.celular.nil?
    cel
  end
  
  def tel_rec
    tel_rec =""
    tel_rec = self.recados unless self.recados.nil?
    tel_rec
  end
  
  def tel_casa
    tel_casa = ""
    tel_casa = self.casa unless self.casa.nil?
    tel_casa
  end
  
  def tel_oficina
    tel_oficina = ""
    tel_oficina = self.oficina unless self.oficina.nil?
    tel_oficina
  end
  def tel_fax
    tel_fax = ""
    tel_fax = self.fax unless self.fax.nil?
    tel_fax
  end
  
  def mail
    mail = ""
    mail = self.correo unless self.correo.nil? 
    mail
  end
  
  def contacto
    cont = ""
    cont = self.nombre_contacto unless self.nombre_contacto.nil? 
    cont
  end
  
end