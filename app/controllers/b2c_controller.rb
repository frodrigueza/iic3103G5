class B2cController < ApplicationController

  def index
    @productos = Producto.all
  end

  def comprar
    @producto = Producto.find_by(sku: params[:sku])
    @sku, @nombre, @precio = @producto[:sku], @producto[:nombre], @producto[:precio]
    @productos = Producto.all
  end
end
