class OrdersManager

	def self.manage_order(oc_id)
        oc = HttpManager.get_oc(oc_id)
        answer = evaluate_order(oc)
        if answer[:status] == 400
          reject_order(oc, answer) if oc[:_id]
          return answer
        end

        pedido = create_order_db(oc)
        if pedido and pedido[:fecha_entrega] > DateTime.now
            accept_order(oc, answer)
            LogManager.new_log(pedido , "Orden de Compra recepcionada correctamente.")
        elsif pedido and pedido[:fecha_entrega] < DateTime.now
            reject_order(oc, {content:{mensaje: "Fecha entrega obsoleta"}}) if oc[:_id]
            LogManager.new_log(pedido , "Orden de Compra no recepcionada ya que esta obsoleta.")
        end
	    return answer
	end


    def self.create_order_db(oc)
        # Revisar si es un producto o no, y en ese caso setear los insumos y sus cantidades (y el boolean). Finalmente, retornar el pedido.
        pedido = Pedido.find_by oc_id: oc[:_id]
        if not pedido
            pedido = Pedido.create(:oc_id => oc[:_id],
                                  :canal => oc[:canal],
                                  :cliente => oc[:cliente].to_i,
                                 :fecha_entrega => DateTime.parse(oc[:fechaEntrega].to_s).utc,
                                 :sku => oc[:sku],
                                 :cantidad => oc[:cantidad],
                                 :movimientos_inventario => "",
                                 :cantidad_producida => "",
                                 :compras_insumos => "",
                                 :numero_facturas => "",
                                 :movimientos_bancarios => "",
                                 :despachado => false
                                 )
            insumos = []
            tipo = ProductoManager.get_datos_sku(oc[:sku])[:tipo]
            if tipo == "insumo"
              pedido[:producto_compuesto] = false
              insumos.push create_insumos(pedido[:sku], pedido[:cantidad])
            else
              pedido[:producto_compuesto]  = true
              insumos = detect_insumos(pedido)
            end 
            pedido.insumos = insumos
            pedido.save
            return pedido
        end
        return nil
    end

    def self.reject_order(order, answer)
        # Setear la oc como rechazada en API curso
        HttpManager.rechazar_oc(id_oc: order[:_id], rechazo: answer[:content][:mensaje])
        # Notificar orden rechazada a grupo cliente
        GruposManager.order_rejected(group: order[:cliente], order_id: order[:_id]) if order[:canal] == "b2b"
    end


    def self.accept_order(order, answer)
        # Setear la oc como aceptada en API curso
        HttpManager.recepcionar_oc(order[:_id])
        # Notificar orden aceptada a grupo cliente
        GruposManager.order_accepted(group: order[:cliente], order_id: order[:_id]) if order[:canal] == "b2b"
    end

    # vemos si es posible generar una orden de compra para un pedido determinado
    # hash contiene los valores de los parametros pedidos
    def self.evaluate_order(oc)
    # Agregar un verificador de si oc existe o si es error 404
        # oc es nula
        if not oc[:_id]
            answer = {
                status: 400,
                content: {
                mensaje: "La orden de compra no es valida"
                }
            }
        # corresponde a nuestr empersa
        elsif oc[:proveedor] != GroupInfo.grupo
            answer = {
                status: 400,
                content: {
                    mensaje: "El proveedor numero #{oc[:proveedor]} no corresponde a nuestra empresa, nosotros somos la empresa #{GroupInfo.grupo}"
                }
            }
        elsif oc[:canal] == "b2b" and not ["1","2","3","4","6","7","8"].include? oc[:cliente]
            answer = {
                status: 400,
                content: {
                mensaje: "Cliente inválido debe ser uno de los siguientes [1,2,3,4,6,7,8]"
                 }
            }
        # corresponde a los skus que nosostros trabajamos
        elsif !GroupInfo.skus.include?(oc[:sku])
            answer = {
                status: 400,
                content: {
                mensaje: "Nosotros como empresa 5 no manejamos ese SKU, solo manejamos los skus #{GroupInfo.skus}"
                 }
            }
        else         
            answer = {
                status: 200,
                content: {
                    mensaje: "La orden de compra #{oc[:_id]} ha sido recepcionada correctamente"
                }
            }
        end
        return answer
    end

    def self.cantidad_de_lotes(pedido)
        lote = ProductoManager.insumos_necesarios.find{|encontrados| encontrados['sku_final'] == pedido[:sku] }['cant_lote']
        return (pedido[:cantidad].to_f/lote.to_f).ceil
    end

    def self.detect_insumos(pedido)
        cantidad_de_lotes = cantidad_de_lotes(pedido)
        insumos = []
        ProductoManager.insumos_necesarios.select {|encontrados| encontrados['sku_final'] == pedido[:sku] }.each do |ins|
            if ins['requerimiento'] > 0
                insumos.push create_insumos(ins['sku_insumo'], (ins['requerimiento'] * cantidad_de_lotes).ceil)
            end
        end
        return insumos
    end

    def self.create_insumos(sku, cantidad)
        insumo = Insumo.create(:sku => sku, :cantidad => cantidad)
        return insumo
    end
end