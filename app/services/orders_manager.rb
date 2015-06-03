class OrdersManager

	def self.manage_order(oc_id)
		oc = HttpManager.get_oc(oc_id)
	    answer = evaluate_order(oc)
	    if answer[:status] == 400
	      reject_order(oc, answer)
	      return answer
	    else
	      accept_order(oc_id, answer)
	    end

	    pedido = create_order_db(oc)
        PedidoManager.check_pedidos

	    return answer
	end

  def self.create_order_db(oc)
    # Revisar si es un producto o no, y en ese caso setear los insumos y sus cantidades (y el boolean). Finalmente, retornar el pedido.
    pedido = Pedido.find_by oc_id: oc[:_id]
    if  pedido == nil
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
                             :movimientos_bancarios => ""
                             )
        insumos = []
        tipo = define_type_order(oc)
        if tipo == "insumo"
          pedido[:producto_compuesto] = false
          insumos.push create_insumos(pedido[:sku], pedido[:cantidad])
        else
          pedido[:producto_compuesto]  = true
          insumos = detect_insumos(pedido)
        end 
        pedido.insumos = insumos
        return pedido
    end
    return nil
  end

  def self.insumos_necesarios
    insumos_necesarios = [
        {'sku_final' => '4', 'cant_lote' => 200, 'sku_insumo' => '38', 'requerimiento' => 190},
        {'sku_final' => '5', 'cant_lote' => 600, 'sku_insumo' => '49', 'requerimiento' => 228},
        {'sku_final' => '5', 'cant_lote' => 600, 'sku_insumo' => '6', 'requerimiento' => 228},
        {'sku_final' => '5', 'cant_lote' => 600, 'sku_insumo' => '41', 'requerimiento' => 194},
        {'sku_final' => '6', 'cant_lote' => 30, 'sku_insumo' => '49', 'requerimiento' => -270},
        {'sku_final' => '6', 'cant_lote' => 30, 'sku_insumo' => '7', 'requerimiento' => 300},
        {'sku_final' => '10', 'cant_lote' => 900, 'sku_insumo' => '23', 'requerimiento' => 342},
        {'sku_final' => '10', 'cant_lote' => 900, 'sku_insumo' => '26', 'requerimiento' => 309},
        {'sku_final' => '10', 'cant_lote' => 900, 'sku_insumo' => '27', 'requerimiento' => 279},
        {'sku_final' => '11', 'cant_lote' => 900, 'sku_insumo' => '4', 'requerimiento' => 828},
        {'sku_final' => '12', 'cant_lote' => 400, 'sku_insumo' => '25', 'requerimiento' => 133.3333333},
        {'sku_final' => '12', 'cant_lote' => 400, 'sku_insumo' => '20', 'requerimiento' => 146.6666667},
        {'sku_final' => '12', 'cant_lote' => 400, 'sku_insumo' => '15', 'requerimiento' => 113.3333333},
        {'sku_final' => '16', 'cant_lote' => 1000, 'sku_insumo' => '23', 'requerimiento' => 330},
        {'sku_final' => '16', 'cant_lote' => 1000, 'sku_insumo' => '26', 'requerimiento' => 313.3333333},
        {'sku_final' => '16', 'cant_lote' => 1000, 'sku_insumo' => '2', 'requerimiento' => 383.3333333},
        {'sku_final' => '17', 'cant_lote' => 1000, 'sku_insumo' => '25', 'requerimiento' => 360},
        {'sku_final' => '17', 'cant_lote' => 1000, 'sku_insumo' => '20', 'requerimiento' => 350},
        {'sku_final' => '17', 'cant_lote' => 1000, 'sku_insumo' => '13', 'requerimiento' => 290},
        {'sku_final' => '18', 'cant_lote' => 200, 'sku_insumo' => '23', 'requerimiento' => 72},
        {'sku_final' => '18', 'cant_lote' => 200, 'sku_insumo' => '2', 'requerimiento' => 71.33333333},
        {'sku_final' => '18', 'cant_lote' => 200, 'sku_insumo' => '7', 'requerimiento' => 66.66666667},
        {'sku_final' => '22', 'cant_lote' => 400, 'sku_insumo' => '6', 'requerimiento' => 380},
        {'sku_final' => '23', 'cant_lote' => 300, 'sku_insumo' => '8', 'requerimiento' => 309},
        {'sku_final' => '24', 'cant_lote' => 400, 'sku_insumo' => '33', 'requerimiento' => 444},
        {'sku_final' => '28', 'cant_lote' => 500, 'sku_insumo' => '37', 'requerimiento' => 440},
        {'sku_final' => '29', 'cant_lote' => 400, 'sku_insumo' => '31', 'requerimiento' => 368},
        {'sku_final' => '30', 'cant_lote' => 500, 'sku_insumo' => '21', 'requerimiento' => 460},
        {'sku_final' => '34', 'cant_lote' => 700, 'sku_insumo' => '14', 'requerimiento' => 332.5},
        {'sku_final' => '34', 'cant_lote' => 700, 'sku_insumo' => '27', 'requerimiento' => 318.5},
        {'sku_final' => '35', 'cant_lote' => 500, 'sku_insumo' => '44', 'requerimiento' => 430},
        {'sku_final' => '36', 'cant_lote' => 100, 'sku_insumo' => '45', 'requerimiento' => 89},
        {'sku_final' => '40', 'cant_lote' => 900, 'sku_insumo' => '7', 'requerimiento' => 1000},
        {'sku_final' => '40', 'cant_lote' => 900, 'sku_insumo' => '41', 'requerimiento' => -100},
        {'sku_final' => '41', 'cant_lote' => 200, 'sku_insumo' => '7', 'requerimiento' => 2000},
        {'sku_final' => '41', 'cant_lote' => 200, 'sku_insumo' => '40', 'requerimiento' => -1800},
        {'sku_final' => '42', 'cant_lote' => 200, 'sku_insumo' => '25', 'requerimiento' => 66.66666667},
        {'sku_final' => '42', 'cant_lote' => 200, 'sku_insumo' => '20', 'requerimiento' => 71.33333333},
        {'sku_final' => '42', 'cant_lote' => 200, 'sku_insumo' => '3', 'requerimiento' => 68.66666667},
        {'sku_final' => '46', 'cant_lote' => 800, 'sku_insumo' => '20', 'requerimiento' => 296},
        {'sku_final' => '46', 'cant_lote' => 800, 'sku_insumo' => '25', 'requerimiento' => 269.3333333},
        {'sku_final' => '46', 'cant_lote' => 800, 'sku_insumo' => '7', 'requerimiento' => 250.6666667},
        {'sku_final' => '47', 'cant_lote' => 1000, 'sku_insumo' => '39', 'requerimiento' => 495},
        {'sku_final' => '47', 'cant_lote' => 1000, 'sku_insumo' => '27', 'requerimiento' => 570},
        {'sku_final' => '47', 'cant_lote' => 1000, 'sku_insumo' => '25', 'requerimiento' => 1000},
        {'sku_final' => '48', 'cant_lote' => 500, 'sku_insumo' => '19', 'requerimiento' => 160},
        {'sku_final' => '48', 'cant_lote' => 500, 'sku_insumo' => '26', 'requerimiento' => 171.6666667},
        {'sku_final' => '48', 'cant_lote' => 500, 'sku_insumo' => '2', 'requerimiento' => 155},
        {'sku_final' => '49', 'cant_lote' => 200, 'sku_insumo' => '7', 'requerimiento' => 222.2222222},
        {'sku_final' => '49', 'cant_lote' => 200, 'sku_insumo' => '6', 'requerimiento' => -22.22222222}]
  end

  def self.cantidad_de_lotes(pedido)
    lote = insumos_necesarios.find{|encontrados| encontrados['sku_final'] == pedido[:sku] }['cant_lote']
    cantidad_de_lotes = (pedido[:cantidad].to_f/lote.to_f).ceil
  end

  def self.detect_insumos(pedido)
    cantidad_de_lotes = cantidad_de_lotes(pedido)
    insumos = []
    insumos_necesarios.select {|encontrados| encontrados['sku_final'] == pedido[:sku] }.each do |ins|
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


  def self.define_type_order(oc)
    tipos_segun_sku ={
        '1' => 'insumo',
        '2' => 'insumo',
        '3' => 'insumo',
        '4' => 'compuesto',
        '5' => 'compuesto',
        '6' => 'compuesto',
        '7' => 'insumo',
        '8' => 'insumo',
        '9' => 'insumo',
        '10' => 'compuesto',
        '11' => 'compuesto',
        '12' => 'compuesto',
        '13' => 'insumo',
        '14' => 'insumo',
        '15' => 'insumo',
        '16' => 'compuesto',
        '17' => 'compuesto',
        '18' => 'compuesto',
        '19' => 'insumo',
        '20' => 'insumo',
        '21' => 'insumo',
        '22' => 'compuesto',
        '23' => 'compuesto',
        '24' => 'compuesto',
        '25' => 'insumo',
        '26' => 'insumo',
        '27' => 'insumo',
        '28' => 'compuesto',
        '29' => 'compuesto',
        '30' => 'compuesto',
        '31' => 'insumo',
        '32' => 'insumo',
        '33' => 'insumo',
        '34' => 'compuesto',
        '35' => 'compuesto',
        '36' => 'compuesto',
        '37' => 'insumo',
        '38' => 'insumo',
        '39' => 'insumo',
        '40' => 'compuesto',
        '41' => 'compuesto',
        '42' => 'compuesto',
        '43' => 'insumo',
        '44' => 'insumo',
        '45' => 'insumo',
        '46' => 'compuesto',
        '47' => 'compuesto',
        '48' => 'compuesto',
        '49' => 'compuesto'}
    return tipos_segun_sku[oc[:sku]]
  end

  
	# vemos si es posible generar una orden de compra para un pedido determinado
	# hash contiene los valores de los parametros pedidos
	def self.evaluate_order(oc)
    # Agregar un verificador de si oc existe o si es error 404
		answer = {
			status: 200,
            content: {
                mensaje: "La orden de compra " + oc[:_id] + " ha sido recepcionada correctamente"
            }
		}

		# corresponde a nuestr empersa
		if oc[:proveedor] != GroupInfo.grupo
			answer = {
				status: 400,
                content: {
				    mensaje: "El proveedor numero " + oc[:proveedor] + " no corresponde a nuestra empresa, nosotros somos la empresa " + GroupInfo.grupo
			     }
            }
        elsif !["1","2","3","4","6","7","8"].include? oc[:cliente]
            answer = {
                status: 400,
                content: {
                mensaje: "Cliente inválido debe ser uno de los siguientes [1,2,3,4,6,7,8]"
                 }
            }
		# corresponde a los skus que nosostros trabajamos
		elsif !GroupInfo.skus.include?(oc[:sku].to_i )
			answer = {
				status: 400,
                content: {
				mensaje: "Nosotros como empresa 5 no manejamos ese SKU, solo manejamos los skus " + GroupInfo.skus.to_s
			     }
            }

		# la orden de compra no es nula
		elsif oc[:_id] == nil
			answer = {
				status: 400,
                content: {
				mensaje: "El id de la orden de compra no es valido"
                }
			}
        end

		return answer

	end

    def reject_order(order, answer)
      # Setear la oc como rechazada en API curso
      HttpManager.reject_order(id_oc: order[:_id], motivo: answer[:content][:mensaje])
      # Notificar orden rechazada a grupo cliente
      GruposManager.order_rejected(group: order[:cliente], order_id: order[:_id])
    end


    def accept_order(order, answer)
        # Setear la oc como aceptada en API curso
      HttpManager.recepcionar_oc(order[:_id])
        # Notificar orden aceptada a grupo cliente
      GruposManager.order_accepted(order_id: order[:_id])
    end


end