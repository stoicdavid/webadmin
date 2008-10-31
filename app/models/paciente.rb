class Paciente < ActiveRecord::Base
  has_many :consultas, :dependent => :delete_all
  has_many :doctors, :through => :consultas
  has_many :citas, :dependent => :delete_all
  has_many :operations, :through => :citas

  
  GENERO = [ 
  # Displayed stored in db 
  [ "Masculino", "m" ], 
  [ "Femenino", "f" ]
  ]
  validates_presence_of :nombre, :app_pat, :app_mat,:genero, :on => :create, :message => " no puede ser vacio"
  validates_inclusion_of :genero, :in => GENERO.map {|disp, value| value}

  def consulta_atributos=(atributos)
#    atributos.each do |a|
      consultas.build(atributos)
 #   end
  end

  
  def nombres
    [nombre,nombre_2].join(' ')
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
  
  def edad
      now = Time.now.utc
      now.year - self.fecha_nac.year - (self.fecha_nac.to_time.change(:year => now.year) > now ? 1 : 0)
  end
  
  def nombre_medio
    self.nombre + " " + self.app_pat
  end

  def nombres
    nombre = self.nombre
    if self.nombre_2!=nil
      nombre += ' ' + self.nombre_2
    end
    nombre
  end
  def nombre_completo
  	nombres + " " + self.app_pat + " " + self.app_mat
  end
  
  def codigo
    cod = ""
    if self.cp_fis.to_s.length == 4
      cod+='0' + self.cp_fis.to_s
    else 
      cod = self.cp_fis.to_s
    end
    cod
  end
  
  def direccion_fiscal_completa
    if calle_fis!=nil and colonia_fis!=nil and self.estado_fis!=nil 
      d = self.calle_fis + " " + self.colonia_fis + " " + self.del_mun + " " + codigo + ", " + self.estado_fis
	  else
	    d=""
	  end
  end

  def domicilio_completo
    self.calle_dom + " " + self.colonia_dom + " " + self.estado_dom
  end
end
