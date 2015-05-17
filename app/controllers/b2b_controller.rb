class B2bController < ApplicationController
	before_action :set_orders_manager, only: [:new_order, :notify_accepted_order, :notify_rejected_order, :cancel_previous_order, :ask_for_token]

	# documentacion
	def documentation
	end

	# API para otros grupos
	def new_order
	end

	def notify_accepted_order
    # Este método debe ir acompañado por un parámetro que es un string del id de la orden de compra.
    # Este parámetro se pasará más abajo como id de orden de compra.

    # Primero hay que verificar Token. Si no existe, retornar error 401
    require 'net/http'
    result = Net::HTTP.get(URI.parse('http://chiri.ing.puc.cl/atenea/obtener/id'))

    if result == error then
      # retornar error
    else
      # retornar que está bien. Hay que ver si esto debiera ir acompañado de un pago.
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
