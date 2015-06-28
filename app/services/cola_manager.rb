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

			   #fecha = Time.at(mensaje[:fin]).utc
			   mensaje_tweeter = "OFERTA! Sku: #{mensaje[:sku]} a sólo #{mensaje[:precio]} pesos!"

			   
			   #AQUI SE DEBERIA MANDAR MENSAJE DE TWITTER
			

			else
				#puts "El SKU #{mensaje[:sku]} no es uno de nuestros SKUs"

				#fecha = Time.at(mensaje[:fin]).utc

				
			end



							

		end

		
		conn.close

		


		
	end	


end