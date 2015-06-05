class PedidoManager

  def self.check_ready(pedido)

    insumos_listos = true

    # Revisar si producto terminado (sea compuesto o materia prima) está en bodega
    cantidad_disponible = BodegaManager.buscar_en_bodega(pedido.sku)
    #Si no está:
    if cantidad_disponible < pedido.cantidad
      # Hacer foreach que revise cada insumo
      pedido.insumos.each do |insumo|
        # Revisar si esta la cantidad necesaria en bodega. (BodegaManager.buscar_en_bodega)
        cantidad_disponible = BodegaManager.buscar_en_bodega(insumo.sku)
        # Si no está, guardar cantidad que falta
        if cantidad_disponible < insumo.cantidad and not pedido.solicitado
            insumos_listos = false
            cantidad_faltante = insumo.cantidad - cantidad_disponible
            # Revisar si insumo es nuestro
            if not GroupInfo.skus.include? insumo.sku
              # Si no, generar OC con sku y cantidad faltante, revisar fecha de entrega,
                # notificar nueva OC a otro grupo, etc.
              proveedor = get_dato(insumo.sku)[:proveedor] 
              precio_unitario = get_dato(insumo.sku)[:costo].to_i
              order = HttpManager.crear_oc(sku: insumo.sku, proveedor: proveedor, canal: "b2b", precioUnitario: precio_unitario,
               cantidad: cantidad_faltante, cliente: GroupInfo.grupo, fechaEntrega: Helpers.time_to_unix(pedido.fecha_entrega))
              GruposManager.new_order(grupo: proveedor, order_id: order[:_id])
              LogManager.new_log(pedido , "Insumo de sku " + insumo.sku.to_s + " enviado a comprar. Orden de compra : " + order[:_id])
            else
              # Si es nuestro, "extraer" cantidad faltante
              # COMO SE EXTRAEN LAS MATERIAS PRIMAS??
              costo = get_datos(insumo.sku)[:costo] 
              trx = HttpManager.transferir(monto: costo, origen: GroupInfo.cuenta_banco, destino: GroupInfo.cuenta_banco_fabrica)
              HttpManager.producir_stock(sku: insumo.sku,cantidad: insumo.cantidad, trxId: trx[:_id])
              LogManager.new_log(pedido, "Fue extraido insumo de sku: " + insumo.sku.to_s + " cantidad: " + insumo.cantidad.to_s)
            end
        end
      pedido[:solicitado] = true
      pedido.save
      # end foreach
      end


      #If Producto_compuesto = true & orden_lista = true
      if pedido.producto_compuesto and insumos_listos
        # Dejar insumos en almacen de despacho
        pedido.insumos.each do |insumo|
          BodegaManager.mover_a_despacho(insumo.sku, insumo.cantidad)
          LogManager.new_log(pedido, "Insumo de sku: " + insumo.sku.to_s + " enivado al almacen de despacho.")
        end
        # producirStock
        costo = get_dato(pedido.sku)[:costo] 
        trx = HttpManager.transferir(monto: costo, origen: GroupInfo.cuenta_banco, destino: GroupInfo.cuenta_banco_fabrica)
        LogManager.new_log(pedido , "Trasferencia realizada del banco a la fábrica. Monto: " + costo)
        HttpManager.producir_stock(sku: pedido.sku, cantidad: PedidoManager.cantidad_de_lotes(pedido), trxId: trx[:_id])
        LogManager.new_log(pedido, "Producto de sku: " + pedido.sku.to_s + " producido. Cantidad: " + PedidoManager.cantidad_de_lotes(pedido))
      end
    else
      BodegaManager.mover_a_despacho(pedido.sku, pedido.cantidad)
      LogManager.new_log(pedido, "Product de sku: " + pedido.sku.to_s + " movido a bodega de despacho. Cantidad: " + pedido.cantidad.to_s)
      factura = FacturaManager.emitir_factura(pedido)
      LogManager.new_log(pedido , "Factura emitida: " + factura[:_id])
      BodegaManager.despachar(pedido)
      LogManager.new_log(pedido , "Product de sku: " +  pedido.sku.to_s + " despachado a grupo " + pedido.cliente + ". Cantidad: " + pedido.cantidad.to_s)
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



  def self.get_dato(sku)
    datos_base = {
1 => { proveedor: 1, costo: 1270 }, 
2 => { proveedor: 7, costo: 1289 }, 
3 => { proveedor: 7, costo: 1370 }, 
4 => { proveedor: 1, costo: 1732 }, 
5 => { proveedor: 5, costo: 600 }, 
6 => { proveedor: 1, costo: 6453 }, 
7 => { proveedor: 6, costo: 1696 }, 
8 => { proveedor: 2, costo: 3891 }, 
9 => { proveedor: 2, costo: 2640 }, 
10 => { proveedor: 2, costo: 2523 }, 
11 => { proveedor: 7, costo: 2003 }, 
12 => { proveedor: 2, costo: 1829 }, 
13 => { proveedor: 4, costo: 2780 }, 
14 => { proveedor: 3, costo: 3673 }, 
15 => { proveedor: 3, costo: 3660 }, 
16 => { proveedor: 3, costo: 1251 }, 
17 => { proveedor: 3, costo: 2602 }, 
18 => { proveedor: 3, costo: 3518 }, 
19 => { proveedor: 4, costo: 1917 }, 
20 => { proveedor: 3, costo: 3953 }, 
21 => { proveedor: 4, costo: 2203 }, 
22 => { proveedor: 4, costo: 2629 }, 
23 => { proveedor: 4, costo: 2747 }, 
24 => { proveedor: 4, costo: 1988 }, 
25 => { proveedor: 8, costo: 1588 }, 
26 => { proveedor: 5, costo: 1946 }, 
27 => { proveedor: 5, costo: 631 }, 
28 => { proveedor: 5, costo: 1069 }, 
29 => { proveedor: 5, costo: 3988 }, 
30 => { proveedor: 5, costo: 1390 }, 
31 => { proveedor: 1, costo: 979 }, 
32 => { proveedor: 1, costo: 1252 }, 
33 => { proveedor: 6, costo: 3332 }, 
34 => { proveedor: 6, costo: 891 }, 
35 => { proveedor: 6, costo: 3375 }, 
36 => { proveedor: 6, costo: 2052 }, 
37 => { proveedor: 2, costo: 2363 }, 
38 => { proveedor: 2, costo: 2041 }, 
39 => { proveedor: 2, costo: 3111 }, 
40 => { proveedor: 7, costo: 3299 }, 
41 => { proveedor: 7, costo: 29691 }, 
42 => { proveedor: 2, costo: 3446 }, 
43 => { proveedor: 8, costo: 1297 }, 
44 => { proveedor: 5, costo: 3043 }, 
45 => { proveedor: 8, costo: 2646 }, 
46 => { proveedor: 8, costo: 1031 }, 
47 => { proveedor: 1, costo: 1496 }, 
48 => { proveedor: 8, costo: 3256 }, 
49 => { proveedor: 1, costo: 717 }
}

return datos_base[sku.to_i]
end


end