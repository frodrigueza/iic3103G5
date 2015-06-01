class FacturaManager

  def self.emitir_factura(oc)
    #crear factura

    #notificar factura a grupo
  end

  def self.recibir_factura(id_factura)
    #Criterio para aceptar o rechazar factura
    # Si acepta factura
      # Setear factura aceptada en API del curso
      # Pagar factura
      # Llamar a PedidoManager.check_ready
    # Si no
      # Rechazar factura
      # Notificar factura rechazada

    #return algo

  end
end