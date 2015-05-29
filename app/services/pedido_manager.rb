class PedidoManager

  def self.check_ready

    orden_lista = true


    # Revisar si producto terminado (sea compuesto o materia prima) está en bodega

      #Si no está:
        # Hacer foreach que revise cada insumo

          # Revisar si esta la cantidad necesaria en bodega. (BodegaManager.buscar_en_bodega)
            # Si no está, guardar cantidad que falta y cambiar orden_lista a false
              # Revisar si insumo es nuestro
                # Si no, generar OC con sku y cantidad faltante, revisar fecha de entrega,
                  # notificar nueva OC a otro grupo, etc.
                # Si es nuestro, "extraer" cantidad faltante
        # End Foreach
        #If Producto_compuesto = true & orden_lista = true
          # Dejar insumos en almacen de despacho
          # producirStock
          # pausa que espere a que el producto este listo
      #return orden_lista
  end


end