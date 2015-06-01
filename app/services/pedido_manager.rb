class PedidoManager

  def self.check_ready(pedido)

    orden_lista = true

    # Revisar si producto terminado (sea compuesto o materia prima) está en bodega
    cantiadad_disponible = BodegaManager.buscar_en_bodega(pedido.sku)
    #Si no está:
    if(cantiadad_disponible < pedido.cantidad)
      # Hacer foreach que revise cada insumo
      pedido.insumos.each do |insumo|
        # Revisar si esta la cantidad necesaria en bodega. (BodegaManager.buscar_en_bodega)
        cantiadad_disponible = BodegaManager.buscar_en_bodega(insumo.sku)
        # Si no está, guardar cantidad que falta y cambiar orden_lista a false
        if(cantiadad_disponible == 0)
          orden_lista = false
          cantidad_faltante = insumo.cantidad - cantiadad_disponible
            # Revisar si insumo es nuestro
            if(not GroupInfo.skus.include? insumo.sku)
              # Si no, generar OC con sku y cantidad faltante, revisar fecha de entrega,
                # notificar nueva OC a otro grupo, etc.
              proveedor = get_dato(insumo.sku)[:proveedor] 
              precio_unitario = get_dato(insumo.sku)[:costo] 
              id_oc = HttpManager.create_order(sku: insumo.sku, proveedor: proveedor, canal: "b2b", precio_unitario: precio_unitario,
               cantiadad: cantidad_faltante, cliente: GroupInfo.id, fecha_entrega: pedido.fecha_entrega)
              HttpManager.notificar_new_order(grupo: proveedor, id_oc: id_oc)
            else
              # Si es nuestro, "extraer" cantidad faltante
              # COMO SE EXTRAEN LAS MATERIAS PRIMAS??
              costo = get_dato(insumo.sku)[:costo] 
              trx = HttpManager.transferir(monto: costo, origen: GroupInfo.cuenta_banco, destino: GroupInfo.cuenta_banco_fabrica)
              HttpManager.fabricar(sku: insumo.sku, trxId: trx[:_id])
            end
        end
      # end foreach
      end


      #If Producto_compuesto = true & orden_lista = true
      if pedido.producto_compuesto and orden_lista
        # Dejar insumos en almacen de despacho
        pedido.insumos.each do |insumo|
          BodegaManager.mover_a_despacho(insumo.sku)
        end
        # producirStock
        costo = get_dato(pedido.sku)[:costo] 
        trx = HttpManager.transferir(monto: costo, origen: GroupInfo.cuenta_banco, destino: GroupInfo.cuenta_banco_fabrica)
        HttpManager.fabricar(sku: pedido.sku, trxId: trx[:_id])

######### pausa que espere a que el producto este listo

        BodegaManager.mover_a_despacho(pedido.sku)
        BodegaManager.despachar(pedido.oc)
      end
    end
    #return orden_lista
    return orden_lista
  end

#se llama cada cierto tiempo. ver pedidos con fecha > hoy , priorizar por fecha.
# para cada uno check ready
def self.check_pedidos()
  pedidos.find_each do |pedido|
    
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

return datos_base[sku] 
end


end