class AddEstudio < ActiveRecord::Migration
  def self.up
    Estudio.create(:tipo_estudio => 'Electroencefalograma', :precio => 1000 )
    Estudio.create(:tipo_estudio => 'Video Electroencefalograma',:precio => 1000)
    Estudio.create(:tipo_estudio => 'Poligráfico de sueño',:precio => 1000 )
    Estudio.create(:tipo_estudio => 'Potenciales evocados',:precio => 1000 )
    Estudio.create(:tipo_estudio => 'Electromiografías',:precio => 1000 )
  end

  def self.down
    
  end
end
