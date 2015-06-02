class HttpManager

	@@uri = 'http://chiri.ing.puc.cl:8080/grupo5/webresources/'


	def self.crear_oc(body)

		url = @@uri +'atenea/crear' 

		response = HTTParty.put(url, 
			:body => body.to_json,
    		:headers => { 'Content-Type' => 'application/json'})

		order_hash = JSON.parse(response.body)[0].symbolize_keys
	
	end

	def self.recepcionar_oc(id_oc)

		url = @@uri + 'atenea/recepcionar/' + id_oc.to_s

		response = HTTParty.post(url , :body => {:id=>id_oc }.to_json , :headers =>{ 'Content-Type' => 'application/json'})

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

		response = HTTParty.post(url , :body => {}.to_json , :headers =>{ 'Content-Type' => 'application/json'})

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

	# def self.transferir(body)

	# 	url = @@uri + 'apolo/trx/'

	# 	response = HTTParty.put(url , 
	# 		:query => {:monto => body[:monto] , :origen => body[:origen], :destino => body[:destino]}.to_json ,
	# 		:body  => {}.to_json,
	# 		:headers =>{ 'Content-Type' => 'application/json'})

	# 	order_hash = JSON.parse(response.body)[0].symbolize_keys

	# end

	def self.obtener_transaccion(id_t)

		url = @@uri + 'apolo/trx/' + id_t.to_s

		response = HTTParty.get(url)

		order_hash = JSON.parse(response.body)[0].symbolize_keys

	end

	# def self.obtener_cartola(body)

	# 	url = @@uri + 'apolo/cartola/'

	# 	response = HTTParty.post(url , 
	# 		:query => {:fechaInicio => body[:fecha_inicio] , :fechaFin => body[:fecha_fin], :id => body[:id_cb], :limit => body[:limit]}.to_json ,
	# 		:body  => {}.to_json,
	# 		:headers =>{ 'Content-Type' => 'application/json'})

	# 	order_hash = JSON.parse(response.body)[0].symbolize_keys

	# end

	def self.obtener_cartola(id_cb)

		url = @@uri + 'apolo/banco/cuenta/' + id_cb.to_s

		response = HTTParty.get(url)

		order_hash = JSON.parse(response.body)[0].symbolize_keys

	end

	def self.test
		puts "hola"
		hash = get_oc('5563933be0949e0300344fda')
		puts hash
	end

end
