class B2cController < ApplicationController

  def index
    @productos = Producto.all
  end

  def comprar
    @producto = Producto.find_by(sku: params[:sku])
    @sku, @nombre, @precio = @producto[:sku], @producto[:nombre], @producto[:precio]
    @productos = Producto.all
  end

  def pagar
    precioUnitario = params[:precioUnitario].to_i
    if promo = Promo.activas.find_by(codigo: params[:promocion])
      precioUnitario = promo[:precio]
    end
    total = precioUnitario * params[:cantidad].to_i
    boleta = HttpManager.crear_boleta(cliente: params[:cliente], proveedor: GroupInfo.id, total: total)
    params[:boletaId] = boleta[:_id]
    callbackUrl = url_for(controller: 'b2c', action: 'pagado') + "?#{params.except(:controller, :action, :promocion).to_query}"
    cancelUrl = url_for(controller: 'b2c', action: 'index')
    params = {
      callbackUrl: callbackUrl,
      cancelUrl: cancelUrl,
      boletaId: boleta[:_id]
    }
    redirect_to(GroupInfo.url_pago_en_linea + "?#{params.to_query}")
  end

  def pagado
    order = HttpManager.crear_oc(
      sku: params.require(:sku),
      proveedor: GroupInfo.grupo,
      canal: 'b2c',
      precioUnitario: params.require(:precioUnitario),
      cantidad: params.require(:cantidad),
      cliente: params.require(:cliente),
      fechaEntrega: Helpers.time_to_unix(params.require :fechaEntrega)
    )
    OrdersManager.manage_order(order[:_id])
    pedido = Pedido.find_by(oc_id: order[:_id])
    boletaId = params.require(:boletaId)
    LogManager.new_log(pedido , "Boleta creada: #{boletaId}.")
  end

end
