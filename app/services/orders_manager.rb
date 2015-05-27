class OrdersManager

	def manage_order(order_id)
		httpm = HttpManager.new()

		order = httpm.get_order(order_id)		
	end

	# vemos si es posible generar una orden de compra para un pedido determinado
	# hash contiene los valores de los parametros pedidos
	def evaluate_order(hash)
		# respuesta a devolver
		answer = {
			status: 200,
			mensaje: ""
		}

		# corresponde a nuestr empersa
		if hash["proveedor"] != "5" 
			answer = {
				status: 400,
				mensaje: "El proveedor numero " + hash["proveedor"] + " no corresponde a nuestra empresa, nosotros somos la empresa 6"
			}

		# corresponde a los skus que nosostros trabajamos
		elsif !skus.include?(hash["sku"].to_i )
			answer = {
				status: 400,
				mensaje: "Nosotros como empresa 5 no manejamos ese SKU, solo manejamos los skus [5, 26, 27, 29, 30, 44]"
			}

		# la orden de compra no es nula
		elsif hash["oc"] == nil
			answer = {
				status: 400,
				mensaje: "El id de la orden de compra es nulo"
			}

		# todo en orden
		else
			answer = {
				status: 200,
				mensaje: "La orden de commpra " + hash["oc"] + " ha sido recepcionada correctamente"
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
		
	end


	
	# skus que trabaja la empresa
	def skus
		return [5, 26, 27, 28, 29, 30, 44]
	end

end