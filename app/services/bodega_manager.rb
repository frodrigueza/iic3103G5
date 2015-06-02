class BodegaManager



  def self.mover_a_despacho(sku,cantidad)
    #Revisar en bodega o en almacen pulmon

    
     #Revisar todos los almacenes con sku que se pide con getSTock
     #Si es que hay en agun almacen (despacho, libre, pulmon), tomo id y uso MoverStock la cantiadad requerida
     #Se manda al almacen de desapacho (hardcodear almacen_despacho)
  end

  def self.buscar_en_bodega(sku)
    # Retorna la cantidad disponible. Llama al getSkusWithStock
  end

  def self.despachar(oc)

  end
end