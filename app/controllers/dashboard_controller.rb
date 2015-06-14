class DashboardController < ApplicationController

  def index
    @capacidad_todos = BodegaManager.capacidad_bodega('todos')
    @capacidad_libre = BodegaManager.capacidad_bodega('libre')
    @capacidad_recepcion = BodegaManager.capacidad_bodega('recepcion')
    @capacidad_despacho = BodegaManager.capacidad_bodega('despacho')
    @capacidad_pulmon = BodegaManager.capacidad_bodega('pulmon')

    @productos_todos = BodegaManager.obtener_cantidades_bodega('todos')
    @productos_libre = BodegaManager.obtener_cantidades_bodega('libre')
    @productos_recepcion = BodegaManager.obtener_cantidades_bodega('recepcion')
    @productos_despacho = BodegaManager.obtener_cantidades_bodega('despacho')
    @productos_pulmon = BodegaManager.obtener_cantidades_bodega('pulmon')


  end




end
