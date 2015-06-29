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
		@productos_todos = (@productos_libre + @productos_recepcion + @productos_despacho + @productos_pulmon).uniq
	end

	def orders
		
	end

	def skus_by_canal
		respond_to do |format|
			format.json { render json: DashboardsManager.skus_by_canal }
		end
	end

	def orders_by_deliver_date
		respond_to do |format|
			format.json { render json: DashboardsManager.orders_by_deliver_date(params[:canal]) }
		end
	end
end
