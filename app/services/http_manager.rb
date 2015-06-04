class HttpManager

	@@uri = GroupInfo.url_api_curso

	@@auth_header = 'INTEGRACION grupo5:' 

	@@url_bodega = GroupInfo.url_api_bodega

	def self.crear_oc(body)

		url = @@uri +'atenea/crear' 

		response = HTTParty.put(url, 
			:body => body.to_json,
    		:headers => { 'Content-Type' => 'application/json'})
		order_hash = JSON.parse(response.body).symbolize_keys #funciona
	
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

    # boolean para ver si una orden existe
    def self.exist_order(id_oc)
		response = get_oc(id_oc)
		if response[:_id]
			true
		else
			false
		end
    end

    # boolean para ver si una orden existe
    def self.exist_invoice(invoice_id)
		response = obtener_factura(invoice_id)
		if response[:_id]
			true
		else
			false
		end
    end


	def self.despachar(id_oc)

		url = @@uri + 'atenea/despachar/' + id_oc.to_s

		response = HTTParty.post(url, :headers =>{ 'Content-Type' => 'application/json'})

		order_hash = JSON.parse(response.body)[0].symbolize_keys

	end

	
	def self.emitir_factura(id_oc)

		url = @@uri + 'zeuz/' 

		response = HTTParty.put(url , :body => {:oc => id_oc}.to_json , :headers =>{ 'Content-Type' => 'application/json'})

		order_hash = JSON.parse(response.body).symbolize_keys

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

	def self.get_stock(body)

		url = @@url_bodega + 'stock'

		hash = BodegaHash.crear_hash('GET' + body[:id_a].to_s + body[:sku].to_s)

		header = @@auth_header + hash

		response = HTTParty.get(url, :query => {:almacenId => body[:id_a].to_s, :sku => body[:sku], :limit => body[:limit] }, :headers => {'Authorization' => header})

		response_json = JSON.parse(response.body)

		aux = []
		response_json.each do |sku|
			aux.push sku.symbolize_keys
		end

		order_hash = aux

	end

	def self.mover_stock(body) #funciona

		url = @@url_bodega + 'moveStock'

		hash = BodegaHash.crear_hash('POST' + body[:id_p].to_s  + body[:id_a].to_s )

		header = @@auth_header + hash

		response = HTTParty.post(url, 
			:body => {:productoId => body[:id_p].to_s, :almacenId => body[:id_a].to_s}.to_json, 
			:headers => {'Authorization' => header , 'Content-Type' => 'application/json' })

		order_hash = JSON.parse(response.body).symbolize_keys

	end

	def self.mover_stock_bodega(body)

		url = @@url_bodega + 'moveStockBodega'

		hash = BodegaHash.crear_hash('POST' + body[:id_p].to_s  + body[:id_a].to_s )

		header = @@auth_header + hash

		response = HTTParty.post(url, 
			:body => {:productoId => body[:id_p].to_s, :almacenId => body[:id_a].to_s}.to_json, 
			:headers => {'Authorization' => header , 'Content-Type' => 'application/json' })

		order_hash = JSON.parse(response.body).symbolize_keys

	end

	def self.despachar_stock(body)

		url = @@url_bodega + 'stock'

		hash = BodegaHash.crear_hash('DELETE' + body[:id_p].to_s  + body[:direccion].to_s + body[:precio].to_s + body[:orden_de_compra_id].to_s)

		header = @@auth_header + hash

		response = HTTParty.delete(url,
			:body => {:productoId => body[:id_p].to_s, :direccion => body[:direccion].to_s, :precio => body[:precio], :pedidoId => body[:orden_de_compra_id]}.to_json, 
			:headers => {'Authorization' => header , 'Content-Type' => 'application/json' }) 

			# :query => {:productoId => body[:id_p].to_s, :direccion => body[:direccion].to_s, :precio => body[:precio], :pedidoId => body[:orden_de_compra_id]}, 
			# :body => {}.to_json,
			# :headers => {'Authorization' => header , 'Content-Type' => 'application/json' })


		# response_json = JSON.parse(response.body)

		# aux = []
		# response_json.each do |sku|
		# 	aux.push sku.symbolize_keys
		# end

		order_hash = JSON.parse(response.body).symbolize_keys

	end

	def self.producir_stock(body)

		url = @@url_bodega + 'fabrica/fabricar'

		hash = BodegaHash.crear_hash('PUT' + body[:sku].to_s + body[:cantidad] + body[:trx_id].to_s )

		header = @@auth_header + hash

		response = HTTParty.delete(url, 
			:query => {:sku => body[:sku].to_s, :cantidad => body[:cantidad], :trxId => body[:trx_id].to_s}, 
			:body => {}.to_json,
			:headers => {'Authorization' => header , 'Content-Type' => 'application/json' })


		# response_json = JSON.parse(response.body)

		# aux = []
		# response_json.each do |sku|
		# 	aux.push sku.symbolize_keys
		# end

		order_hash = JSON.parse(response.body)[0].symbolize_keys

	end

	def self.get_cuenta_fabrica #listo

		url = @@url_bodega + 'fabrica/getCuenta'

		hash = BodegaHash.crear_hash('GET')

		header = @@auth_header + hash

		response = HTTParty.get(url , :headers => {'Authorization' => header})

		order_hash = JSON.parse(response.body).symbolize_keys

	end

	def self.test
		puts "hola"
		body = { :id_p => '556489e7efb3d7030091beca',
				 :id_a => '556489e7efb3d7030091bdce',
				}

		hash = mover_stock(body)
	end

end
