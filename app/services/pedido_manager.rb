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
              proveedor = ProductoManager.get_datos_sku(insumo[:sku])[:proveedor]
              precio_unitario = ProductoManager.get_datos_sku(insumo[:sku])[:costo]
              order = HttpManager.crear_oc(sku: insumo[:sku], proveedor: proveedor, canal: "b2b", precioUnitario: precio_unitario,
               cantidad: cantidad_faltante, cliente: GroupInfo.grupo, fechaEntrega: Helpers.time_to_unix(pedido.fecha_entrega))
              response = GruposManager.new_order(group: proveedor, order_id: order[:_id])
              LogManager.new_log(pedido , "Insumo de sku: #{order[:sku]} enviado a comprar. Cantidad: #{order[:cantidad]}, Proveedor: grupo #{order[:proveedor]}, Orden de compra: #{order[:_id]}.")
              if not response
                LogManager.new_log(pedido , "Falló notificación de orden de compra: #{order[:_id]} al grupo #{order[:proveedor]}.")
              elsif response.code == 400
                LogManager.new_log(pedido , "Orden de compra: #{order[:_id]} rechazada por el grupo #{order[:proveedor]}.")
              elsif response.code == 200
                LogManager.new_log(pedido , "Orden de compra: #{order[:_id]} aceptada por el grupo #{order[:proveedor]}.")
              elsif response.code == 500
                LogManager.new_log(pedido , "Ocurrió un error en la orden de compra: #{order[:_id]} enviada al grupo #{order[:proveedor]}, que notificó status: #{response.code}, lo que implica que es un error interno del proveedor.")
              else
                LogManager.new_log(pedido , "Falló notificación de orden de compra: #{order[:_id]} al grupo #{order[:proveedor]} recibió status: #{response.code}.")
              end
            else
              # Si es nuestro, "extraer" cantidad faltante
              # COMO SE EXTRAEN LAS MATERIAS PRIMAS??
              costo = ProductoManager.get_datos_sku(insumo[:sku])[:costo] * insumo[:cantidad]
              trx = HttpManager.transferir(monto: costo, origen: GroupInfo.cuenta_banco, destino: GroupInfo.cuenta_banco_fabrica)
              LogManager.new_log(pedido, "Transferido a la cuenta de banco de la fabrica: $ #{trx[:monto]}.")
              producir = HttpManager.producir_stock(sku: insumo[:sku],cantidad: insumo[:cantidad], trxId: trx[:_id])
              LogManager.new_log(pedido, "Insumo de sku: #{insumo[:sku]} enviado a producir. Cantidad: #{insumo[:cantidad]}, Disponible: #{producir[:disponible]}")
            end
        end
      # end foreach
      end

      pedido[:solicitado] = true
      pedido.save

      #If Producto_compuesto = true & orden_lista = true
      if pedido.producto_compuesto and insumos_listos
        # Dejar insumos en almacen de despacho
        pedido.insumos.each do |insumo|
          BodegaManager.mover_a_despacho(insumo[:sku], insumo[:cantidad])
          LogManager.new_log(pedido, "#{pedido[:cantidad]} unidades de insumo de sku: [#{pedido[:sku]}] en almacen de despacho.")
        end
        # producirStock
        costo = ProductoManager.get_datos_sku(pedido[:sku])[:costo] * pedido[:cantidad]
        trx = HttpManager.transferir(monto: costo, origen: GroupInfo.cuenta_banco, destino: GroupInfo.cuenta_banco_fabrica)
        LogManager.new_log(pedido , "Trasferencia realizada del banco a la fábrica. Monto: #{costo}.")
        cantidad_a_producir = OrdersManager.cantidad_de_lotes(pedido) * ProductoManager.insumos_necesarios.find{|encontrados| encontrados['sku_final'] == pedido[:sku] }['cant_lote']
        response = HttpManager.producir_stock(sku: pedido[:sku], cantidad: cantidad_a_producir, trxId: trx[:_id])
        LogManager.new_log(pedido, "Producto de sku: [#{pedido[:sku]}] enviado a producir. Cantidad: #{cantidad_a_producir}, Disponible: #{response[:disponible]}")
      end
    else
      BodegaManager.mover_a_despacho(pedido[:sku], pedido[:cantidad])
      LogManager.new_log(pedido, "#{pedido[:cantidad]} unidades de producto de sku: [#{pedido[:sku]}] en almacen de despacho.")
      if pedido[:canal] == "b2b"
        factura = FacturaManager.emitir_factura(pedido)
        LogManager.new_log(pedido , "Factura emitida: #{factura[:_id]}.")
      else 
        boleta = HttpManager.crear_boleta(pedido)
        LogManager.new_log(pedido , "Boleta creada: #{boleta[:_id]}.")
      end
      BodegaManager.despachar(pedido)
      LogManager.new_log(pedido , "Product de sku: [#{pedido[:sku]}] despachado a cliente #{pedido[:cliente]}. Cantidad: #{pedido[:cantidad]}.")
    end
  end

#se llama cada cierto tiempo. ver pedidos con fecha > hoy , priorizar por fecha.
# para cada uno check ready
def self.check_pedidos
  pedidos = Pedido.activos
  pedidos.each do |pedido|
    check_ready(pedido) if HttpManager.exist_order(pedido[:oc_id])
  end
  BodegaManager.ordenar_bodega(0)
end


end