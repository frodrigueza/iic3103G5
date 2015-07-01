class PedidosController < ApplicationController
  def index
    if params[:id]
      oc_id = params[:id]
      @oc = HttpManager.get_oc(oc_id)
      if @oc[:_id]
        @pedido = Pedido.find_by(oc_id: oc_id)
        @logs = @pedido ? @pedido.logs : []
      else
        @oc = nil
      end
      render 'pedido'
    end
    @pedidos = Pedido.all.order fecha_entrega: :desc
    @count = (@pedidos.count)/20 +1
    @page = params[:page] ? params[:page].to_i : 1
    @pedidos_pagina = @pedidos[(@page-1)*20...@page*20]


  end

  # def index
  #   @pedidos = Pedido.all.order :fecha_entrega
  # end


end
