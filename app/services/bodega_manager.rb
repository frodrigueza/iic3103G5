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

  def self.get_direccion(cliente)

    case cliente

      when "1"
        return "Mohrenstraße 82, 10117 Berlin, Germany"
      when "2"
        return "Denezhnyy per., 9 стр. 1, Moscow, Russia"
      when "3"
        return "Rigillis 15, 10674 Atenas"
      when "4"
        return "Nº2 Saleh Ayoub Suite 41, Zamalek, Cairo"
      when "5"
        return "2290 Yan An West Road. Shanghai"
      when "6"
        return "Calle de Lagasca, 89, 29010 Madrid, Spain"
      when "7"
        return "10 Culgoa CircuitO'Malley, australia"
      when "8"
        return "169 Garsfontein Road,  Delmondo Office Park, Sudafrica"
      when "9"
        return "Balvanera Buenos Aires, Argentina"      
      when "10"
        return "Alvarez Condarco 740 Las Heras, Mendoza, Argentina"
      when "11"
        return "Avda Cristobal Colon 3707 Santiago" 
      when "12"
        return 
      when "13"
      when "14"
      when "15"
      when "16"
      when "17"
      when "18"
      when "19"
      when "20"
      when "21"

    end


  end


  def self.despachar(pedido)
    
    id_ordenCompra = pedido[:oc_id]
    cliente = pedido[:cliente]
    direccion = get_direccion(cliente)
    sku_pedido = pedido[:sku]


    if pedido[:canal] == 'b2b'
      puts 'Es b2b'

      
      
      








      

    elsif pedido[:canal] == 'ftp'

      cantidad = pedido[:cantidad]

      body = {:id_a => GroupInfo.almacen_despacho, :sku => sku_pedido}
      productosEnDespacho = HttpManager.get_stock(body)

      if productosEnDespacho != nil

        i=0

        productosEnDespacho.each do |producto|

          id_producto = producto[:_id].to_s
          precio = 1


          #puts "Despachando: " + id_producto + "\nPrecio=" + precio.to_s + "\nDireccion: " + direccion + "\nId de OC: " + id_ordenCompra

          body = {:id_p => id_producto, :direccion => direccion, :precio => precio, :orden_de_compra_id => id_ordenCompra.to_s}
          
          prodDespachado = HttpManager.despachar_stock(body)
          puts prodDespachado




          i+=1

          if i==cantidad
            
            break
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

end