class FacturaManager

  def self.emitir_factura(oc)
    #crear factura
    factura = HttpManager.emitirFactura(oc)

    return factura
    #notificar factura a grupo
  end

  def self.recibir_factura(id_factura)

    facturaRecibida = HttpManager.obtenerFactura(id_factura)

    if facturaRecibida.cliente!='5'
      error = HttpManager.rechazarFactura(id_factura, 'no somos nosotros')
      return error 
    #Rechazar en el futuro si nos falta $$$
    else

      pagado = HttpManager.pagarFactura(id_factura)   

      PedidoManager.check_ready

      return pagado

    #Criterio para aceptar o rechazar factura
    # Si acepta factura
      # Setear factura aceptada en API del curso
      # Pagar facturaRecibida
      # Llamar a PedidoManager.check_ready
    # Si no
      # Rechazar factura
      # Notificar factura rechazada

    #return algo

  end
end