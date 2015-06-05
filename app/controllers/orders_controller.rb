class OrdersController < ApplicationController
  before_action only: [:obtain_order]
  require 'net/http'
  require "uri"
  require 'httparty'
  require 'json'

  def new
  	redirect_to :back
  end

  def obtain_order
    order_id = params[:order_id]

    uri = URI.parse('http://chiri.ing.puc.cl/atenea/obtener/' + order_id.to_s)
    response = Net::HTTP.get_response(uri)

    order_hash = JSON.parse(response.body)[0]

    #actual_order = order.select(orderid = order_id)

    if order_hash["_id"] != nil
      render 'home/index', :locals => { :init => "yes", :id => order_hash["_id"], :fechaCreacion => order_hash["fechaCreacion"], :canal => order_hash["canal"], :proveedor => order_hash["proveedor"], :cliente => order_hash["cliente"], :sku => order_hash["sku"], :cantidad => order_hash["cantidad"], :cantidadDespachada => order_hash["cantidadDespachada"], :precioUnitario => order_hash["precioUnitario"], :fechaEntrega => order_hash["fechaEntrega"], :fechasDespachos => order_hash["fechasDespachos"], :estado => order_hash["estado"], :motivoRechazo => order_hash["motivoRechazo"], :motivoAnulacion => order_hash["motivoAnulacion"], :notas => order_hash["notas"], :idFactura => order_hash["idFactura"]}
    else
      render 'home/index', :locals => { :init => "no", :error => order_hash["msg"]}
    end

  end

  def check_pedidos
    PedidoManager.check_pedidos
    render 'home/index'
  end

  def check_ftp
    SftpService.read_new_orders
    render 'home/index'
  end

  def clear_pedidos
    Pedido.delete_all
    render 'home/index'
  end

  def clear_insumos
    Insumo.delete_all
    render 'home/index'
  end

  def clear_logs
    Log.delete_all
    render 'home/index'
  end

end
