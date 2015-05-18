class B2bController < ApplicationController
	before_action :set_orders_manager, :set_auth_manager, only: [:new_order, :documentation, :notify_accepted_order, :notify_rejected_order, :cancel_previous_order, :ask_for_token]
	require 'net/http'
	require "uri"
	require 'httparty'
	require 'json'



	# documentacion
	def documentation
	end

	# API para otros grupos
	def new_order
		order_id = params[:order_id]

		uri = URI.parse('http://chiri.ing.puc.cl/atenea/obtener/' + order_id.to_s)
	    response = Net::HTTP.get_response(uri)

	    order_hash = JSON.parse(response.body)[0]
	    id_oc = order_hash["_id"]
	    cliente = order_hash["cliente"]

	    #Lista de codigos que poseemos. Si no esta 
	    skus = [5,26,27,28,29,30,44]

	    accepted = false

	    if id != nil 
	    	if order_hash["proveedor"] == "5" and order_hash["canal"] == "b2b" and skus.include? order_hash["sku"]

	    			accepted = true

	    			#Recepcionar OC
	    			uri = URI.parse('http://chiri.ing.puc.cl/atenea/obtener/' + order_id.to_s)
					response = Net::HTTP.post_form(uri, id_oc)

					#Revisar stock de materia prima en el almacen 55
					id_almacen = "554be8d4b6355d03001ff96c"
					hash = "hY8ytD5TLHvU8wVMUlRS8KQ4jHA="
					header = {'Authorization' => "INTEGRACION grupo5:"+ hash}
					query = {almacenId: id_almacen}
					uri = URI.parse('http://integracion-2015-dev.herokuapp.com/bodega/skusWithStock/')
					response = HTTParty.get(uri,:query => query,:headers => header)
					#Ver si el stock es suficiente

					#mover stock a bodega de despacho

					#despachar


					#Emitir factura
					@id_factura = "12345"

			end
		end
					

	    respond_to do |format|
    		if accepted
    			format.json {render json: {id_oc: id_oc, id_factura: @id_factura}, status: 200}
    		else
    		 	format.json {render json: {msg: 'Orden de compra no valida'}, status: 400}
    		end
	    end


	end

	def notify_accepted_order
	    order_id = params[:order_id]

	    uri = URI.parse('http://chiri.ing.puc.cl/atenea/obtener/' + order_id.to_s)
	    response = Net::HTTP.get_response(uri)

	    order_hash = JSON.parse(response.body)[0]

	    respond_to do |format|
		    if order_hash["_id"] != nil
	    		format.json {render json: {respuesta: 'Muchas gracias por avisar'}, status: 200}
		    else
	    		format.json {render json: {respuesta: 'Bad request error, ' + order_hash["msg"]}, status: 400}
		    end
	    end
	
    end

		

	def notify_rejected_order
		order_id = params[:order_id]

	    uri = URI.parse('http://chiri.ing.puc.cl/atenea/obtener/' + order_id.to_s)
	    response = Net::HTTP.get_response(url)

	    order_hash = JSON.parse(response.body)[0]

	    respond_to do |format|
		    if order_hash["_id"] != nil
	    		format.json {render json: {respuesta: 'Muchas gracias por avisar'}, status: 200}
		    else
	    		format.json {render json: {respuesta: 'Bad request error, ' + order_hash["msg"]}, status: 400}
		    end
	    end	
	end

	def cancel_previous_order
		
	end

	def ask_for_token
		username = params[:username]
		password = params[:password]

		respond_to do |format|
			if @auth_manager.get_token(username, password)
				format.json { render json:{token: @auth_manager.get_token(username, password)}, status: 200}
			else
				format.json {render json: {respuesta: 'Autenticación errónea'}, status: 401}
			end
		end
	end

	private
	def set_orders_manager
		@om = OrdersManager.new
	end

	def set_auth_manager
		@auth_manager = AuthManager.new
	end
end
