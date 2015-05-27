class HttpManager
	def self.get_order(order_id)
		uri = URI.parse('http://chiri.ing.puc.cl/atenea/obtener/' + order_id.to_s)
	    response = Net::HTTP.get_response(uri)

	    order_hash = JSON.parse(response.body)[0]
	end
end