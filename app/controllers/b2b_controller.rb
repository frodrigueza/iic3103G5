class B2bController < ApplicationController
	before_action :check_token, except: [:new_user, :documentation, :ask_for_token]
	before_action :check_order_id, only:[:order_accepted, :order_canceled, :order_rejected, :new_order]
	before_action :check_invoice_id, only:[:invoice_created, :invoice_paid, :invoice_rejected]

	require 'net/http'
	require "uri"
	require 'httparty'
	require 'json'

	def documentation
	end

	def new_user
		respond_to do |format|
			response = AuthManager.register(params)
			format.json { render json: response[:content], status: response[:status]}
		end
	end

	def get_token
		respond_to do |format|
			response = AuthManager.get_token(params)
			format.json { render json: response[:content], status: response[:status]}
		end
	end
	
	# ORDERS
	def new_order
		answer = OrdersManager.manage_order(params)
		respond_to do |format|
			format.json {render json: answer[:content], status: answer[:status]}
		end
	end

	def order_canceled
		answer = ApiManager.order_canceled(params)
		respond_to do |format|
			format.json {render json: answer[:content], status: answer[:status]}
		end		
	end

	def order_accepted
		answer = ApiManager.order_accepted(params)
		respond_to do |format|
			format.json {render json: answer[:content], status: answer[:status]}
		end
	    
  	end

	def order_rejected
		answer = ApiManager.order_rejected(params)
		respond_to do |format|
			format.json {render json: answer[:content], status: answer[:status]}
		end
	end

	# INVOICES
	def invoice_created
		answer = ApiManager.invoice_created(params)
		respond_to do |format|
			format.json {render json: answer[:content], status: answer[:status]}
		end
	end

	def invoice_paid
		answer = ApiManager.invoice_paid(params)
		respond_to do |format|
			format.json {render json: answer[:content], status: answer[:status]}
		end
	end

	def invoice_rejected
		answer = ApiManager.invoice_rejected(params)
		respond_to do |format|
			format.json {render json: answer[:content], status: answer[:status]}
		end
	end



	private

	# checamos el token que viene en el header antes de cualquier accion de este controlador 
	def check_token
		if !AuthManager.check_token(response.request.env["HTTP_TOKEN"])
			respond_to do |format|
		    	format.json {render json: {respuesta: 'Usuario no autorizado, pruebe llamando al método get_token.'}, status: 401}
		    end
		end
	end


	# VALIDACIONES
    def check_order_id
    	if !params[:order_id]
			respond_to do |format|
		    	format.json {render json: {order_id: 'Campo necesario.'}, status: 400}
		    end
		end
    end

    def check_invoice_id
    	if !params[:invoice_id]
			respond_to do |format|
		    	format.json {render json: {invoice_id: 'Campo necesario.'}, status: 400}
		    end
		end
    end

end
