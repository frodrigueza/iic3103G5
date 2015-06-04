class FacturaManager

  def self.emitir_factura(pedido)
    #crear factura
    factura = HttpManager.emitir_factura(pedido[:oc_id])
    GruposManager.invoice_created(grupo: pedido[:cliente], invoice_id: factura[:_id])
    return factura
  end

  def self.recibir_factura(id_factura)

    factura_recibida = HttpManager.obtener_factura(id_factura)

    if factura_recibida[:proveedor] != '5' || factura_recibida[:proveedor] != 'grupo5'

      body = {:id_f => factura_recibida[:_id], :motivo  => 'Proveedor Erroneo'}
      factura_rechazada = HttpManager.rechazar_factura(body)      

      ## Notificar rechazada

      GruposManager.invoice_rejected(factura_rechazada[:cliente] , factura_rechazada[:_id])

      return 'Proveedor Erroneo'
    end

    cuenta = HttpManager.obtener_cuenta(GroupInfo.cuenta_banco)
    saldo = cuenta[:saldo]

    if saldo > factura_recibida[:total]
      pedido = Pedido.find_by oc_id: factura_recibida[:oc]
      factura_pagada = HttpManager.pagar_factura(factura_recibida[:_id])
      trx = {:monto => factura_pagada[:total] , :origen => GroupInfo.cuenta_banco, :destino => GruposInfo.get_cuenta_id(factura_pagada[:proveedor])}
      transferencia  = HttpManager.transferir(trx)
      GruposManager.invoice_pagada(factura_recibida[:cliente] , factura_pagada[:_id])
      LogManager.new_log(pedido, "Factura " + factura_pagada[:_id] + " de la orden de compra " + factura_recibida[:oc] + " ha sido pagada. Transferencia: " + transferencia[:_id])
      return "Factura pagada. Recibirán notificación vía API"
    end

    return 'Esta siendo procesada'
  end


  def self.factura_fue_rechazada(id_factura)

    #acciones correspondientes a una factura rechazada
    

  end



end