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


    parametros=HttpManager.get_skus_with_stock(GroupInfo.almacen_despacho)

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


  def self.despachar(pedido)
    
    id_ordenCompra = pedido[:oc_id]
    cliente = pedido[:cliente]
    direccion = GruposInfo.get_direccion(cliente)
    sku_pedido = pedido[:sku]


    if pedido[:canal] == 'b2b'

      cantidad = pedido[:cantidad].to_i
      idDespachoDestino = GruposInfo.get_recepcion_id(cliente)




      body = {:id_a => GroupInfo.almacen_despacho, :sku => sku_pedido}
      productosEnDespacho = HttpManager.get_stock(body)

      if productosEnDespacho != nil

        i=0
        productosEnDespacho.each do |producto|

          id_producto = producto[:_id].to_s

          body2 = {:id_p => id_producto, :id_a => idDespachoDestino}

          despacharAOtroGrupo = HttpManager.mover_stock_bodega(body2)


          i= i + 1

          if i>=cantidad
            puts "Despachado"
            pedido[:despachado]=true
            pedido.save
            return
          end

        end
        
      end


      

    elsif pedido[:canal] == 'ftp'

      cantidad = pedido[:cantidad].to_i

      body = {:id_a => GroupInfo.almacen_despacho, :sku => sku_pedido}
      productosEnDespacho = HttpManager.get_stock(body)

      if productosEnDespacho != nil

        i=0
        nDespachados=0

        productosEnDespacho.each do |producto|

          id_producto = producto[:_id].to_s
          precio = 1


          #puts "Despachando: " + id_producto + "\nPrecio=" + precio.to_s + "\nDireccion: " + direccion + "\nId de OC: " + id_ordenCompra

          body = {:id_p => id_producto, :direccion => direccion, :precio => precio, :orden_de_compra_id => id_ordenCompra.to_s}
          
          prodDespachado = HttpManager.despachar_stock(body)
          #puts prodDespachado

          if prodDespachado[:despachado] == true
            #puts "PRODUCTO DESPACHADO"
            nDespachados+=1
          end


          i+=1

          if i >= cantidad
            if(nDespachados==cantidad)
              pedido[:despachado]=true
              puts "Se despacharon todos"
              
            else
              pedido[:despachado]=false
              puts "No se despacharon todos"

            end

            
            return;
          end
        end




        
      end





      


      #pedido[:despachado] = true
    elsif pedido[:canal] == 'b2c'
      #TODO: Por implementar
        
    else
      puts 'Error en canal'

    end

  end

  def self.obtener_cantidades_bodega(almacen)

    products = []
    if almacen == "todos" or almacen == "libre"
      parametros = HttpManager.get_skus_with_stock(GroupInfo.almacen_libre)

      if parametros!=nil

        parametros.each do |producto|
          products = BodegaManager.push_products_total(products, producto)
        end
      end
    end

    if almacen == "todos" or almacen == "pulmon"
      parametros=HttpManager.get_skus_with_stock(GroupInfo.almacen_pulmon)

      if parametros!=nil

        parametros.each do |producto|
          products = BodegaManager.push_products_total(products, producto)
        end
      end
    end

    if almacen == "todos" or almacen == "recepcion"
      parametros=HttpManager.get_skus_with_stock(GroupInfo.almacen_recepcion)

      if parametros!=nil

        parametros.each do |producto|
          products = BodegaManager.push_products_total(products, producto)
        end
      end
    end

    if almacen == "todos" or almacen == "despacho"
      parametros=HttpManager.get_skus_with_stock(GroupInfo.almacen_despacho)

      if parametros!=nil

        parametros.each do |producto|
          products = BodegaManager.push_products_total(products, producto)
        end
      end
    end
    return products
    # Retorna todos los productos
  end

  # Hay que cambiarle el nombre
  def self.push_products_total(products, producto)
    temp = products.find{|prod| prod[:_id] == producto[:_id]}
    if temp.nil?
      products.push producto
    else
      temp = {:id => temp[:_id], :total => temp[:total] + producto[:total]}
      products.delete_if{|prod| prod[:_id] == producto[:_id]}
      products.push temp
    end
  end

  def self.capacidad_bodega(bodega)

    almacenes = HttpManager.get_almacenes
    porcentaje = 0.to_f

    if bodega == 'todos'
      libre = almacenes.find{|alm| alm[:_id] == GroupInfo.almacen_libre}
      recepcion = almacenes.find{|alm| alm[:_id] == GroupInfo.almacen_recepcion}
      despacho = almacenes.find{|alm| alm[:_id] == GroupInfo.almacen_despacho}
      porcentaje = (libre[:usedSpace]
                  + recepcion[:usedSpace]
                  + despacho[:usedSpace]).to_f / (libre[:totalSpace]
                                              + recepcion[:totalSpace]
                                              + despacho[:totalSpace])*100

    elsif bodega == 'libre'

      libre = almacenes.find{|alm| alm[:_id] == GroupInfo.almacen_libre}
      uso_libre = libre[:usedSpace].to_f / libre[:totalSpace] * 100
      porcentaje = uso_libre

    elsif bodega == 'recepcion'

      recepcion = almacenes.find{|alm| alm[:_id] == GroupInfo.almacen_recepcion}
      uso_recepcion = recepcion[:usedSpace].to_f / recepcion[:totalSpace] * 100
      porcentaje = uso_recepcion

    elsif bodega == 'despacho'

      despacho = almacenes.find{|alm| alm[:_id] == GroupInfo.almacen_despacho}
      uso_despacho = despacho[:usedSpace].to_f / despacho[:totalSpace] * 100
      porcentaje = uso_despacho

    elsif bodega == 'pulmon'

      pulmon = almacenes.find{|alm| alm[:_id] == GroupInfo.almacen_pulmon}
      uso_pulmon = pulmon[:usedSpace].to_f / pulmon[:totalSpace] * 100
      porcentaje = uso_pulmon

    end

    return porcentaje
    # Retorna la cantidad disponible.
  end

end