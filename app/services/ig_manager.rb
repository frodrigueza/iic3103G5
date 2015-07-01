class IgManager

	def self.tag(params)#perfecto

		if(params[:meta]== nil)

			params_json = params[:_json]

			params_json.each do |update|

				url ='https://api.instagram.com/v1/tags/' + update[:object_id].to_s + '/media/recent/'

				response = HTTParty.get(url,
					:query => {:access_token => GroupInfo.ig_access_token })

				text = response['data'][0]['caption']['text'].to_s

				#text = '#promociones #queso en láminas #oferta sku=40 precio=400 codigo=123abc'

				if text.include? "sku" and text.include? "precio" and text.include? "codigo" and 

					##TODO Actualizar el precio de ese sku en la base de datos 	

					tweet = crear_tweet(text)

					if tweet != "no"

						HttpManager.tweet(tweet: tweet)

					end

				end

			end	

		end

	end

	def self.crear_tweet(text)

		sku = text[text.index('sku')..-1].split(' ')[0]

		sku = sku[sku.index('=')+1 .. -1]

		if !GroupInfo.skus.include? sku
			return "no"
		end 

		precio = text[text.index('precio')..-1].split(' ')[0]

		precio = precio[precio.index('=')+1 .. -1]

		codigo = text[text.index('codigo')..-1].split(' ')[0]

		codigo = codigo[codigo.index('=')+1 .. -1]

		Promo.create(sku: sku, precio: precio.to_i, codigo: codigo)

		return mensaje_tweeter = "OFERTA DE INSTAGRAM! Sku: " + sku +" a sólo " + precio + " pesos! Código: " + codigo

	end


end
