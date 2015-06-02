class BodegaManager



  def self.mover_a_despacho(sku,cantidad)

    #BUscamos en almacen de despacho primero
    parametros=HttpManager.get_skus_with_stock(GroupInfo.almacen_despacho)
    numeroEnDespacho =0

    if(parametros!=nil)

      parametros.each do |producto| 

        if producto[:_id].to_s == sku.to_s
          numeroEnDespacho = producto[:total]
        end 

      end
    end
   

    parametros = HttpManager.get_skus_with_stock(GroupInfo.almacen_libre)
    


    if(parametros!=nil)



      parametros.each do |producto|   

        if producto[:_id].to_s == sku.to_s
          numero = producto[:total]

          if cantidad <= numero
            cantidad = cantidad - numeroEnDespacho

          
          else
            cantidad=numero
            cantidad = cantidad - numeroEnDespacho
          end
          
          break

        end 



      end

      #puts numeroEnDespacho
      
      body = {:id_a => GroupInfo.almacen_libre, :sku => sku}
      productosSku = HttpManager.get_stock(body)
      #puts productosSku
      i=0
       
      productosSku.each do |itemProducto|
         body2 = {:id_a => GroupInfo.almacen_despacho, :id_p => itemProducto[:_id].to_s}
         prodMovido = HttpManager.mover_stock(body2)
         #puts itemProducto[:_id].to_s
         #Si no hay espacio, metodo HttpManager.mover_stock(body2) retorna ERROR FALTA ESPACIO
         #puts prodMovido
         #puts 'Despacho id ' + itemProducto[:_id].to_s
         i+=1

         if i == cantidad
          break
         end
      end

    end









    #Revisar en bodega o en almacen pulmon

    
     #Revisar todos los almacenes con sku que se pide con getSTock
     #Si es que hay en agun almacen (despacho, libre, pulmon), tomo id y uso MoverStock la cantiadad requerida
     #Se manda al almacen de desapacho (hardcodear almacen_despacho)
  end

  #Si no encuentra SKU devuelve 0
  def self.buscar_en_bodega(sku)

    parametros = HttpManager.get_skus_with_stock(GroupInfo.almacen_libre)
    numero = 0
    
    if(parametros!=nil)

      parametros.each do |producto|   

        if producto[:_id].to_s == sku.to_s
          numero = producto[:total]
        end 
      end
    end

    parametros=HttpManager.get_skus_with_stock(GroupInfo.almacen_pulmon)

    if(parametros!=nil)

      parametros.each do |producto| 

        if producto[:_id].to_s == sku.to_s
          numero += producto[:total]
        end 

      end
    end

    parametros=HttpManager.get_skus_with_stock(GroupInfo.almacen_recepcion)

    if(parametros!=nil)

      parametros.each do |producto| 

        if producto[:_id].to_s == sku.to_s
          numero += producto[:total]
        end 

      end
    end


    return numero
    # Retorna la cantidad disponible. 
  end

  def self.despachar(oc)

  end
end