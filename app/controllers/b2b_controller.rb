class B2bController < ApplicationController
	before_action :set_orders_manager, only: [:new_order, :notify_accepted_order, :notify_rejected_order, :cancel_previous_order, :ask_for_token]
	require 'net/http'
	require "uri"


	# documentacion
	def documentation
	end

	# API para otros grupos
	def new_order
		order_id = params[:order_id]

		uri = URI.parse('http://chiri.ing.puc.cl/atenea/obtener/' + order_id.to_s)
	    response = Net::HTTP.get_response(url)

	    order_hash = JSON.parse(response.body)[0]

	    #Lista de codigos que poseemos. Si no esta 
	    skus = [5,26,27,28,29,30,44]
	    id_oc = order_hash["_id"]
	    accepted = false

	    if id != nil 
	    	if order_hash["proveedor"] == "5" and order_hash["canal"] == "b2b" and skus.include? order_hash["sku"]

	    			accepted = true

	    			#Recepcionar OC
	    			uri = URI.parse('http://chiri.ing.puc.cl/atenea/obtener/' + order_id.to_s)
					response = Net::HTTP.post_form(uri, id_oc)

					#Revisar stock de materia prima en el almacen 55
					


			end
		end
					

	    respond_to do |format|
    		if accepted
    			format.json {render json: {id_oc: id_oc, id_factura: id_factura}, status: 200}
    		else
    		 	format.json {render json: {msg: 'Orden de compra no valida'}, status: 400}
    		end
	    end


	end

	def notify_accepted_order
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

		

	def notify_rejected_order
		
	end

	def cancel_previous_order
		
	end

	def ask_for_token
		
	end	

	private
	def set_orders_manager
		@om = OrdersManager.new
	end
end
