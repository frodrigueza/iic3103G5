class FacturaManager

  def self.emitir_factura(pedido)
    #crear factura
    factura = HttpManager.emitir_factura(pedido[:oc_id])
    GrupoManager.invoice_created(invoice_id: factura[:_id])
  end

  def self.recibir_factura(id_factura)

    facturaRecibida = HttpManager.obtenerFactura(id_factura)

    if facturaRecibida.cliente!='5'
      error = HttpManager.rechazarFactura(id_factura, 'no somos nosotros')
      return error 
    #Rechazar en el futuro si nos falta $$$
    else

      pagado = HttpManager.pagarFactura(id_factura)   

      return pagado

    #Criterio para aceptar o rechazar factura
    # Si acepta factura
      # Setear factura aceptada en API del curso
    # Si no
      # Rechazar factura
      # Notificar factura rechazada

    #return algo

  end



end