class HomeController < ApplicationController
  def index
  	if params[:order_id] && params[:order_id] != ""
  		oc_id = params[:order_id]
  		if HttpManager.exist_order(oc_id)
  			@oc = HttpManager.get_oc(oc_id)
  			if @oc[:_id]
  				@oc = OpenStruct.new(@oc).to_h
  				@pedido = Pedido.find_by(oc_id: oc_id)

  				@logs = @pedido ? @pedido.logs : []
  			else
  				@oc = nil
  			end
  		end
  	end
  end
end
