class PedidoManager

  def self.check_ready(pedido)

    insumos_listos = true

    # Revisar si producto terminado (sea compuesto o materia prima) está en bodega
    cantidad_disponible = BodegaManager.buscar_en_bodega(pedido[:sku])
    #Si no está:
    if cantidad_disponible < pedido[:cantidad]
      # Hacer foreach que revise cada insumo
      pedido.insumos.each do |insumo|
        # Revisar si esta la cantidad necesaria en bodega. (BodegaManager.buscar_en_bodega)
        cantidad_disponible = BodegaManager.buscar_en_bodega(insumo[:sku])
        # Si no está, guardar cantidad que falta
        insumos_listos = false if cantidad_disponible < insumo[:cantidad]
        if not insumos_listos and not pedido[:solicitado]
            cantidad_faltante = insumo[:cantidad] - cantidad_disponible
            # Revisar si insumo es nuestro
            if not GroupInfo.skus.include? insumo[:sku]
              # Si no, generar OC con sku y cantidad faltante, revisar fecha de entrega,
                # notificar nueva OC a otro grupo, etc.
              proveedor = ProductoManager.get_dato(insumo[:sku])[:proveedor]
              precio_unitario = ProductoManager.get_dato(insumo[:sku])[:costo]
              order = HttpManager.crear_oc(sku: insumo[:sku], proveedor: proveedor, canal: "b2b", precioUnitario: precio_unitario,
               cantidad: cantidad_faltante, cliente: GroupInfo.grupo, fechaEntrega: Helpers.time_to_unix(pedido.fecha_entrega))
              response = GruposManager.new_order(group: proveedor, order_id: order[:_id])
              LogManager.new_log(pedido , "Insumo de sku #{insumo[:sku]} enviado a comprar #{insumo[:cantidad]} unidades al grupo #{order[:proveedor]}. Orden de compra: #{order[:_id]}.")
              if not response
                LogManager.new_log(pedido , "Falló notificación de orden de compra: #{order[:_id]} al grupo #{order[:proveedor]}.")
              elsif response[:status] == 400
                LogManager.new_log(pedido , "Orden de compra: #{order[:_id]} rechazada por el grupo #{order[:proveedor]}.")
              else
                LogManager.new_log(pedido , "Orden de compra: #{order[:_id]} aceptada por el grupo #{order[:proveedor]}.")
              end
            else
              # Si es nuestro, "extraer" cantidad faltante
              # COMO SE EXTRAEN LAS MATERIAS PRIMAS??
              costo = ProductoManager.get_dato(insumo[:sku])[:costo]
              trx = HttpManager.transferir(monto: costo, origen: GroupInfo.cuenta_banco, destino: GroupInfo.cuenta_banco_fabrica)
              LogManager.new_log(pedido, "Transferido a la cuenta de banco de la fabrica: $ #{trx[:monto]}.")
              HttpManager.producir_stock(sku: insumo[:sku],cantidad: insumo[:cantidad], trxId: trx[:_id])
              LogManager.new_log(pedido, "Fue extraido insumo de sku: #{insumo[:sku]}, cantidad: #{insumo[:cantidad]}.")
            end
            pedido[:solicitado] = true
            pedido.save
        end
      # end foreach
      end


      #If Producto_compuesto = true & orden_lista = true
      if pedido.producto_compuesto and insumos_listos
        # Dejar insumos en almacen de despacho
        pedido.insumos.each do |insumo|
          BodegaManager.mover_a_despacho(insumo[:sku], insumo[:cantidad])
          LogManager.new_log(pedido, "Insumo de sku: #{insumo[:sku]} enviado al almacen de despacho.")
        end
        # producirStock
        costo = ProductoManager.get_dato(pedido[:sku])[:costo]
        trx = HttpManager.transferir(monto: costo, origen: GroupInfo.cuenta_banco, destino: GroupInfo.cuenta_banco_fabrica)
        LogManager.new_log(pedido , "Trasferencia realizada del banco a la fábrica. Monto: #{costo}.")
        HttpManager.producir_stock(sku: pedido[:sku], cantidad: OrdersManager.cantidad_de_lotes(pedido), trxId: trx[:_id])
        LogManager.new_log(pedido, "Producto de sku: #{pedido[:sku]} producido. Cantidad: #{pedido[:cantidad]}.")
      end
    else
      BodegaManager.mover_a_despacho(pedido[:sku], pedido[:cantidad])
      LogManager.new_log(pedido, "Product de sku: #{pedido[:sku]} movido a bodega de despacho. Cantidad: #{pedido[:cantidad]}.")
      factura = FacturaManager.emitir_factura(pedido)
      LogManager.new_log(pedido , "Factura emitida: #{factura[:_id]}.")
      BodegaManager.despachar(pedido)
      LogManager.new_log(pedido , "Product de sku: #{pedido[:sku]} despachado a grupo #{pedido[:cliente]}. Cantidad: #{pedido[:cantidad]}.")
    end
  end

#se llama cada cierto tiempo. ver pedidos con fecha > hoy , priorizar por fecha.
# para cada uno check ready
def self.check_pedidos
  pedidos = Pedido.activos
  pedidos.each do |pedido|
    check_ready(pedido) if HttpManager.exist_order(pedido[:oc_id])
  end
end


end