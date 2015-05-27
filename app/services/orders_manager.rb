class OrdersManager

	# vemos si es posible generar una orden de compra para un pedido determinado
	# hash contiene los valores de los parametros pedidos
	def evaluate_order(hash)
		answer = {
			status: 200,
			mensaje: ""
		}

		if hash["canal"] == "ftp"
			# corresponde a un canal ftp

			if hash["proveedor"] == "5" 
				# corresponde a nuestra empresa

				if skus.include?(hash["sku"].to_i )
					# corresponde a un sku que sí trabajamos

					if hash["oc"] != nil
						# la orden de compra no es nula
						# TODO EN ORDEN, PROCESAREMOS LA ORDEN DE COMPRA
						process_order(hash)
					else
						answer = {
							status: 400,
							mensaje: "El id de la orden de compra es nulo"
						}
					end
				else
					answer = {
						status: 400,
						mensaje: "Nosotros como empresa 6 no manejamos ese SKU, solo manejamos los skus [5, 26, 27, 29, 30, 44]"
					}
				end
			else
				answer = {
					status: 400,
					mensaje: "El proveedor numero " + hash["proveedor"] + " no corresponde a nuestra empresa, nosotros somos la empresa 6"
				}
			end
		end

		return answer
	end

	def process_order

		# recepcionamos la orden de compra
		uri = URI.parse('http://chiri.ing.puc.cl/atenea/recepcionar/' + hash["oc"])
		params = {
			order_id: hash["oc"]
		}
		response = Net::HTTP.post_form(uri, params)

		p "orden " + hash["oc"] + " recepcionada satisfactoriamente"
	end


	
	# skus que trabaja la empresa
	def skus
		return [5, 26, 27, 28, 29, 30, 44]
	end

end