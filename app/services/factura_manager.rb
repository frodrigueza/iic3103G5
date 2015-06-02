class FacturaManager

  def self.emitir_factura(pedido)
    #crear factura
    factura = HttpManager.emitir_factura(pedido[:oc_id])
    GrupoManager.invoice_created(invoice_id: factura[:_id])
  end

  def self.recibir_factura(id_factura)

    factura_recibida = HttpManager.obtener_factura(id_factura)

    if factura_recibida[:proveedor] != '5' || factura_recibida[:proveedor] != 'grupo5'

      body = {:id_f => factura_recibida[:_id], :motivo  => 'Proveedor Erroneo'}
      factura_rechazada = HttpManager.rechazar_factura(body)

      ## Notificar rechazada

      return 'Proveedor'

    end

  return 'Esta siendo procesada'

  def self.revisar_pagar_factura(id_factura)

    factura_pagada = HttpManager.pagar_factura(id_factura)


  end

  def self.factura_fue_rechazada(id_factura)

    #acciones correspondientes a una factura rechazada

  end



end