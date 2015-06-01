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
		answer = OrdersManager.manage_order params[:order_id]
		respond_to do |format|
			format.json {render json: answer[:content], status: answer[:status]}
		end

	end

	def order_accepted
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

	def order_rejected
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

	def order_canceled
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
