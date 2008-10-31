class Pago < ActiveRecord::Base
    belongs_to :operation
    
    FORMAS = [ 
    # Displayed stored in db 
    [ "Tarjeta", "t" ], 
    [ "Efectivo", "e" ],
    [ "Cheque", "c" ],
    ]
    
    def folio
      pago = Pago.find(:last)
      pago.folio_factura + 1
    end
    
    def precio_f
      helpers.number_to_currency(self.precio.to_f)
    end

    def descuento_f
      helpers.number_to_currency(self.descuento.to_f)
    end
    
    def iva_f
      helpers.number_to_currency((self.precio.to_f - self.descuento.to_f)*0.15)
    end
    
    def subtotal_f
      helpers.number_to_currency(self.precio.to_f - self.descuento.to_f)
    end
    
    def total_f
      helpers.number_to_currency(self.total.to_f)
    end
    
    def helpers
      ActionController::Base.helpers
    end
    
    
    def self.importe(id)
      @importe = Estudio.find(Operation.find(id).tipo_id).precio
    end
    
    def self.descuento(id)
      
        @descuento = Estudio.find(Operation.find(id).tipo_id).descuento
      if @descuento > 0
        desc = @importe * @descuento
      elsif
        desc = 0
      end
      desc
    end
    
    
end
