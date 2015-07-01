class ColaManager

	def self.recibir

		conn = Bunny.new(GroupInfo.url_cola)
		conn.start

		ch   = conn.create_channel
		q    = ch.queue("ofertas", :auto_delete => true)

		

		delivery_info, metadata, payload = q.pop

		if (payload != nil)

			
			
			mensaje = JSON.parse(payload)
			
			mensaje = mensaje.symbolize_keys

			#verificamos si sku 5,26,27,28,29,30,4	4. Como el mensaje es un string verificamos 
			#que cotenga por ejemplo "sku":"3" <- Formato correspondiente

			if mensaje[:sku] == "5" or mensaje[:sku] == "26" or mensaje[:sku] == "27" or
				mensaje[:sku] == "28" or mensaje[:sku] == "29" or mensaje[:sku] == "30" or 
				mensaje[:sku] == "44"

			   fecha_init = Time.at((mensaje[:inicio].to_i)/1000)
			   fecha_fin = Time.at((mensaje[:fin].to_i)/1000)
			   numero_sku = mensaje[:sku]
			   precio = mensaje[:precio]
				
			   
			   mensaje_tweeter = "OFERTA COLA! Sku: #{mensaje[:sku]} a sólo #{mensaje[:precio]}. Hasta: #{fecha_fin}"


			   body = {:tweet => mensaje_tweeter}
			   HttpManager.tweet(body)
			   
			   #Parámetros que vienen en la cola: numero_sku, precio, fecha_init, fecha_fin 

				
			end



							

		end

		
		conn.close

		


		
	end	


end