class OrdersController < ApplicationController
  before_action only: [:obtain_order]
  require 'net/http'
  require "uri"
  require 'httparty'
  require 'json'

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
