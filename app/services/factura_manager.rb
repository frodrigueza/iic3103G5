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

  def self.revisar_estados_facturas

    Pedido.find_each do |pedido|
      oc = HttpManager.get_order(pedido[:oc_id])
      id_factura = oc[:idFactura]
      if id_factura != nil
        factura = HttpManager.get_factura(id_factura)
        # Revisar si factura está aceptada en la API.
        if factura[:estadoPago] == "aceptada"
          # Si está aceptada, BodegaManager.despachar(oc)
          BodegaManager.despachar(oc)
        end
      end
    end
  end

end