class B2bController < ApplicationController
	before_action :check_token, except: [:new_user, :documentation, :ask_for_token]

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

		p "orden recepcionada ----------------------------------------------- "
		p order_id

		uri = URI.parse('http://chiri.ing.puc.cl/atenea/obtener/' + order_id.to_s)
	    response = Net::HTTP.get_response(uri)

	    order_hash = JSON.parse(response.body)[0]
	    id_oc = order_hash["_id"]
	    cliente = order_hash["cliente"]

	    #Lista de codigos que poseemos. Si no esta 
	    skus = [5,26,27,28,29,30,44]

	    accepted = false

	    if id_oc != nil 
	    	p "paso nil   "
	    	p order_hash["proveedor"]
	    	p order_hash["canal"]
	    	p order_hash["sku"]
	    	if order_hash["proveedor"] == "5" and order_hash["canal"] == "b2b" and skus.include? order_hash["sku"].to_i
	    		p "paso if "

	    			accepted = true

	    			#Recepcionar OC
	    			uri = URI.parse('http://chiri.ing.puc.cl/atenea/recepcionar/' + order_id.to_s)
	    			query = {order_id: id_oc}
					response = Net::HTTP.post_form(uri, query)

					#Revisar stock de materia prima en el almacen libre dispocicion
					id_almacen = "554be8d4b6355d03001ff96c"
					hash = "hY8ytD5TLHvU8wVMUlRS8KQ4jHA="
					header = {'Authorization' => "INTEGRACION grupo5:"+ hash}
					query = {almacenId: id_almacen}
					uri = URI.parse('http://integracion-2015-dev.herokuapp.com/bodega/skusWithStock/')
					response = HTTParty.get(uri,:query => query,:headers => header)
					# response.each do |product|
					# 	if product[:id] == order_hash["sku"]
					# 		if product
								
					# 		end
					# 	end
					# end

					#Ver si el stock es suficiente

					#mover stock a bodega de despacho

					#despachar


					#Emitir factura
					@id_factura = "Emitir factura sin URL en la api del curso"

			end
		end
					

	    respond_to do |format|
    		if accepted
    			format.json {render json: {id_oc: id_oc, id_factura: @id_factura}, status: 200}
    			#format.json {render json: {id_oc: id_oc, id_factura: @id_factura}, status: 200}
    		else
    		 	format.json {render json: {msg: 'Orden de compra no valida'}, status: 400}
    		end
	    end
	end

	def notify_order_accepted
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

	def notify_order_rejected
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

	def notify_order_canceled
		order_id = params[:order_id]

	    uri = URI.parse('http://chiri.ing.puc.cl/atenea/obtener/' + order_id.to_s)
	    response = Net::HTTP.get_response(uri)

	    order_hash = JSON.parse(response.body)[0]

	    respond_to do |format|
		    if order_hash["_id"] != nil
	    		format.json {render json: {respuesta: 'Orden cancelada'}, status: 200}
		    else
	    		format.json {render json: {respuesta: 'Bad request error, ' + order_hash["msg"]}, status: 400}
		    end
	    end
	end

	def new_user
		respond_to do |format|
			response = AuthManager.register(params)
			format.json { render json: response[:content], status: response[:status]}
		end
	end

	def ask_for_token
		respond_to do |format|
			response = AuthManager.get_token(params)
			format.json { render json: response[:content], status: response[:status]}
		end
	end

	private

	# checamos el token que viene en el header antes de cualquier accion de este controlador 
	def check_token
		if !AuthManager.check_token(response.request.env["HTTP_TOKEN"])
			respond_to do |format|
		    	format.json {render json: {respuesta: 'Usuario no autorizado, pruebe llamando al método ask_for_token.'}, status: 401}
		    end
		end
	end

end
