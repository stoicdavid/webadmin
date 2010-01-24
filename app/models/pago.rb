class Pago < ActiveRecord::Base
    belongs_to :operation
    
    FORMAS = [ 
    # Displayed stored in db 
    [ "Tarjeta de Crédito", "tdc" ],    
    [ "American Express", "amex" ],     
    [ "Tarjeta de Débito", "deb" ],    
    [ "Efectivo", "e" ],
    [ "Cheque", "c" ],
    [ "Transferencia", "trans" ],        
    [ "Seguro", "s" ],            
    [ "Pago Parcial", "ant" ],                
    ]
    
    IVA = {2009 => 0.15,2010=>0.16}
    
    def folio
      if pago = Pago.find(:last,:conditions => ['folio_factura IS NOT ?',nil])
        pago.folio_factura + 1
      else
        0
      end
    end
    
    def aplica_descuento(descuento)
      
      
    end
    
    def precio_f
      helpers.number_to_currency(self.precio.to_f)
    end

    def descuento_f
      helpers.number_to_currency(self.descuento.to_f)
    end
    
    def descuento_neg_f
      helpers.number_to_currency(self.descuento.to_f*-1)
    end
    
    def iva
      if self.created_at.year > IVA[IVA.keys.max]
        (self.precio.to_f - self.descuento.to_f)*IVA[IVA.keys.max]
      elsif self.created_at.year < IVA[IVA.keys.min] 
        (self.precio.to_f - self.descuento.to_f)*IVA[IVA.keys.min]
      else
        (self.precio.to_f - self.descuento.to_f)*IVA[self.created_at.year]
      end
    end
    
    def iva_f
      helpers.number_to_currency(self.iva)
    end
    
    def subtotal_f
      helpers.number_to_currency(self.precio.to_f - self.descuento.to_f)
    end
    
    def total_f
      helpers.number_to_currency(self.total.to_f + self.iva.to_f)
    end
    
    def total_l
      (self.total.to_f + self.iva.to_f).round(2)
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
      else
        desc = 0
      end
      desc
    end
    
    
end
