class B2bController < ApplicationController
	before_action :set_orders_manager, only: [:new_order, :notify_accepted_order, :notify_rejected_order, :cancel_previous_order, :ask_for_token]

	# documentacion
	def documentation
	end

	# API para otros grupos
	def new_order
	end

	def notify_accepted_order
		
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
