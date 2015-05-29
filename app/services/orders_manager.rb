class OrdersManager

	def self.manage_order(order_id)


		oc = HttpManager.get_order(order_id)
    answer = evaluate_order(oc)
    if answer["status"] == 400
      reject_order(order_id)
      return
    else
      accept_order(order_id)
    end


    #pedido = create_order_db(oc)

    #pedido_listo = PedidoManager.check_ready

    #if pedido_listo = false
      #return

    # BodegaManager.mover_a_despacho
    # BodegaManager.emitir_factura

    # Esperar 8 días?

    # Revisar si factura está aceptada en la API.
      # Si no está rechazada, BodegaManager.despachar(oc)

    return answer

  end

  def create_order_db(oc)
    # Revisar si es un producto o no, y en ese caso setear los insumos y sus cantidades (y el boolean)
    # retornar el objeto Order con los campos ingresados
  end

	# vemos si es posible generar una orden de compra para un pedido determinado
	# hash contiene los valores de los parametros pedidos
	def self.evaluate_order(oc)
    # Agregar un verificador de si oc existe o si es error 404
		answer = {
			status: 200,
			mensaje: "La orden de compra " + oc["_id"] + " ha sido recepcionada correctamente"
		}

		# corresponde a nuestr empersa
		if oc["proveedor"] != "5"
			answer = {
				status: 400,
				mensaje: "El proveedor numero " + oc["proveedor"] + " no corresponde a nuestra empresa, nosotros somos la empresa 5"
			}

		# corresponde a los skus que nosostros trabajamos
		elsif !GroupInfo.skus.include?(oc["sku"].to_i )
			answer = {
				status: 400,
				mensaje: "Nosotros como empresa 5 no manejamos ese SKU, solo manejamos los skus [5, 26, 27, 29, 30, 44]"
			}

		# la orden de compra no es nula
		elsif oc["_id"] == nil
			answer = {
				status: 400,
				mensaje: "El id de la orden de compra es nulo"
			}
    end

		return answer

	end

	# metodo que procesa la orden internamente
	def process_order(order_id)

		# recepcionamos la orden de compra
		uri = URI.parse('http://chiri.ing.puc.cl/atenea/recepcionar/' + hash["oc"])
		params = {
			order_id: hash["oc"]
		}
		response = Net::HTTP.post_form(uri, params)
		p "orden " + hash["oc"] + " recepcionada satisfactoriamente"



	end

	def reject_order(order_id)
    # Setear la oc como rechazada en API curso
		# Notificar orden rechazada a grupo cliente
	end

  def accept_order(order_id)
    # Setear la oc como aceptada en API curso
    # Notificar orden aceptada a grupo cliente
  end

	


end