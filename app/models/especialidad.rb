class Especialidad < ActiveRecord::Base
  belongs_to :doctor
  
  validates_uniqueness_of :especialidad, :on => :create, :message => "^La especialidad ya existe"

def self.find_all
  find(:all).collect { |p| [p.especialidad, p.id] }
end

end
