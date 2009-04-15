class Cita < ActiveRecord::Base


  belongs_to :paciente
  has_one :operation,:dependent => :destroy 
  has_one :consulta
  has_one :horario
  
  validates_uniqueness_of :fecha_hora, :on => :update, :message => "ya existe con esa fecha" 
    
  state_machine :status, :initial => :activa do
    event :confirmar do
         transition [:activa,:reprogramada] => :confirmada
       end
  
    event :cancelar do
        transition [:activa,:reprogramada,:confirmada,:estudio_en_proceso] => :cancelada
      end

    event :reprogramar do
        transition :reprogramada => same, [:activa,:estudio_fallido,:cancelada,:confirmada] => :reprogramada
      end

    event :generar_id do
        transition [:confirmada] => :estudio_en_proceso
      end
  
    event :concluir_estudio do
        transition [:estudio_en_proceso] => :estudio_exitoso
      end
    
    event :interpretar do
        transition [:estudio_exitoso] => :estudio_interpretado
      end

    event :entregar_estudio do
        transition [:estudio_impreso] => :estudio_entregado
      end
  end
  
  state_machine :state, :initial => :estudio_sin_imprimir, :namespace => 'print' do
    event :imprimir_estudio do
      transition :estudio_sin_imprimir => :estudio_impreso
    end
    
    event :imprimir_interpretacion do
      transition :estudio_impreso  => :estudio_e_interpretacion_impresa
    end
    
    event :compilar_estudio do
      transition [:estudio_e_interpretacion_impresa] => :estudio_completo
    end  
  end
  
  state_machine :status_pago, :initial => :pago_pendiente, :namespace => 'pago' do
    event :pagar_estudio do
      transition :pago_pendiente => :estudio_pagado
    end

  end
  
  
  CUBICULO = [ 
  # Displayed stored in db 
  [ "1", 1 ], 
  [ "2", 2 ]
  ]
    
end
