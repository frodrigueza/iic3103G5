class HttpManager

	@@uri = 'http://chiri.ing.puc.cl:8080/grupo5/webresources/'

	@@auth_header = 'INTEGRACION grupo5:' 

	@@url_bodega = 'http://integracion-2015-dev.herokuapp.com/bodega/'

	def self.crear_oc(body)

		url = @@uri +'atenea/crear' 

		response = HTTParty.put(url, 
			:body => body.to_json,
    		:headers => { 'Content-Type' => 'application/json'})

		order_hash = JSON.parse(response.body).symbolize_keys
	
	end

	def self.recepcionar_oc(id_oc)

		url = @@uri + 'atenea/recepcionar/' + id_oc.to_s

		response = HTTParty.post(url, :body => {}.to_json, :headers =>{ 'Content-Type' => 'application/json'})

		order_hash = JSON.parse(response.body)[0].symbolize_keys

	end

	def self.rechazar_oc(body)


		url = @@uri + 'atenea/rechazar/' + body[:id_oc].to_s

		response = HTTParty.post(url , :body => {:motivo => body[:motivo]}.to_json , :headers =>{ 'Content-Type' => 'application/json'})

		order_hash = JSON.parse(response.body)[0].symbolize_keys

	end

	def self.anular_oc(body)

		url = @@uri + 'atenea/anular/' + body[:id_oc].to_s

		response = HTTParty.delete(url, :body => { :motivo => body[:motivo]}.to_json , :headers =>{ 'Content-Type' => 'application/json'})

		order_hash = JSON.parse(response.body)[0].symbolize_keys

	end

	def self.get_oc(id_oc)

		url = @@uri + 'atenea/obtener/' + id_oc.to_s

	    response = HTTParty.get(url)

	    order_hash = JSON.parse(response.body)[0].symbolize_keys

	end


	def self.despachar(id_oc)

		url = @@uri + 'atenea/despachar/' + id_oc.to_s

		response = HTTParty.post(url, :headers =>{ 'Content-Type' => 'application/json'})

		order_hash = JSON.parse(response.body)[0].symbolize_keys

	end

	
	def self.emitir_factura(id_oc)

		url = @@uri + 'zeuz/' 

		response = HTTParty.put(url , :body => {:oc => id_oc}.to_json , :headers =>{ 'Content-Type' => 'application/json'})

		order_hash = JSON.parse(response.body)[0].symbolize_keys

	end


	def self.obtener_factura(id_f)

		url = @@uri + 'zeuz/' + id_f.to_s

		response = HTTParty.get(url)

		order_hash = JSON.parse(response.body)[0].symbolize_keys

	end

	def self.pagar_factura(id_f)

		url = @@uri + 'zeuz/pay/'

		response = HTTParty.post(url , :body => {:id => id_f}.to_json , :headers =>{ 'Content-Type' => 'application/json'})

		order_hash = JSON.parse(response.body)[0].symbolize_keys

	end

	def self.rechazar_factura(body)

		url = @@uri + 'zeuz/reject/'

		response = HTTParty.post(url , :body => {:id => body[:id_f] , :motivo => body[:motivo]}.to_json , :headers =>{ 'Content-Type' => 'application/json'})

		order_hash = JSON.parse(response.body)[0].symbolize_keys

	end

	def self.anular_factura(body)

		url = @@uri + 'zeuz/cancel/'

		response = HTTParty.post(url , :body => {:id => body[:id_f] , :motivo => body[:motivo]}.to_json , :headers =>{ 'Content-Type' => 'application/json'})

		order_hash = JSON.parse(response.body)[0].symbolize_keys

	end

	def self.transferir(body)

		url = @@uri + 'apolo/trx/'

		response = HTTParty.put(url , 
			:query => {:monto => body[:monto] , :origen => body[:origen], :destino => body[:destino]},
			:headers =>{ 'Content-Type' => 'application/json'})

		order_hash = JSON.parse(response.body)[0].symbolize_keys

	end

	def self.obtener_transaccion(id_t)

		url = @@uri + 'apolo/trx/' + id_t.to_s

		response = HTTParty.get(url)

		order_hash = JSON.parse(response.body).symbolize_keys

	end

	def self.obtener_cartola(body)

		url = @@uri + 'apolo/cartola/'

		response = HTTParty.post(url , 
			:query => {:fechaInicio => body[:fecha_inicio] , :fechaFin => body[:fecha_fin], :id => body[:id_cb], :limit => body[:limit]},
			:headers =>{ 'Content-Type' => 'application/json'})

		order_hash = JSON.parse(response.body)[0].symbolize_keys

	end

	def self.obtener_cartola(id_cb)

		url = @@uri + 'apolo/banco/cuenta/' + id_cb.to_s

		response = HTTParty.get(url)

		order_hash = JSON.parse(response.body).symbolize_keys

	end

	def self.get_almacenes

		url = @@url_bodega + 'almacenes'

		hash = BodegaHash.crear_hash('GET')

		header = @@auth_header + hash

		response = HTTParty.get(url , :headers => {'Authorization' => header})

		response_json = JSON.parse(response.body)
		aux = []
		response_json.each do |bodega|
			aux.push bodega.symbolize_keys
		end

		order_hash = aux

	end

	def self.get_skus_with_stock(id_a)

		url = @@url_bodega + 'skusWithStock'

		hash = BodegaHash.crear_hash('GET' + id_a.to_s)

		header = @@auth_header + hash

		response = HTTParty.get(url , :query => {:almacenId => id_a.to_s}, :headers => {'Authorization' => header})


		response_json = JSON.parse(response.body)
		aux = []
		response_json.each do |sku|
			aux.push sku.symbolize_keys
		end

		order_hash = aux

	end



	def self.test
		puts "hola"
		body = {"canal" => "b2b",
				 "sku" => 5,
				 "cliente" => "5",
				 "proveedor" => "4",
				 "fechaEntrega" =>1433299997000,
				 "cantidad" => 45,
				 "precioUnitario"=> 200
				}

		hash = get_skus_with_stock('556489e7efb3d7030091bdce')
	end

end
