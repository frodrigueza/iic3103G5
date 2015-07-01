class DashboardsController < ApplicationController
	def warehouses
		@capacidad_libre = BodegaManager.capacidad_bodega('libre')
		@capacidad_recepcion = BodegaManager.capacidad_bodega('recepcion')
		@capacidad_despacho = BodegaManager.capacidad_bodega('despacho')
		@capacidad_pulmon = BodegaManager.capacidad_bodega('pulmon')
		@capacidad_todos = @capacidad_libre + @capacidad_recepcion + @capacidad_despacho + @capacidad_pulmon



		@productos_libre = BodegaManager.obtener_cantidades_bodega('libre')
		@productos_recepcion = BodegaManager.obtener_cantidades_bodega('recepcion')
		@productos_despacho = BodegaManager.obtener_cantidades_bodega('despacho')
		@productos_pulmon = BodegaManager.obtener_cantidades_bodega('pulmon')
		@productos_todos = (@productos_libre + @productos_recepcion + @productos_despacho + @productos_pulmon)

		aux = []
		@productos_todos.each do |p1|
			total = p1[:total]
			@productos_todos.each do |p2|
				if p1[:_id] == p2[:_id] && !(p1 === p2)
					total += p2[:total]
				end
			end

			aux << {
				_id: p1[:_id],
				total: total
			}
		end

		@productos_todos = aux.uniq
	end

	def orders
		
	end

	def social
		
	end

	def clients
		
	end

	def bank
		@transactions = DashboardsManager.bank_transactions.reverse
		@bank_result = HttpManager.obtener_cuenta(5)[:saldo]
		if @bank_result >= 0
			@bank_state = 'succes'
		else
			@bank_state = 'danger'
		end
	end


	# AJAX
	def orders_by_sku_group_by_canal
		respond_to do |format|
			format.json { render json: DashboardsManager.orders_by_sku_group_by_canal }
		end
	end

	def orders_by_created_at_date
		respond_to do |format|
			format.json { render json: DashboardsManager.orders_by_created_at_date(params[:canal]) }
		end
	end

	def quantities_by_sku_group_by_canal
		respond_to do |format|
			format.json { render json: DashboardsManager.quantities_by_sku_group_by_canal }
		end
	end

	def service_levels_by_countries
		respond_to do |format|
			format.json { render json: DashboardsManager.service_levels_by_countries }
		end
	end
end
