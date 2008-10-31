class Especialidad < ActiveRecord::Base
  has_one :specialization

def self.find_all
  find(:all).collect { |p| [p.especialidad, p.id] }
end

end
