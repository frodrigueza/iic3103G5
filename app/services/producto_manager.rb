class ProductoManager

  def self.actualizar_precios
    Producto.all.each do |producto|
      sku = producto[:sku]
      if cola = Cola.activas.find_by(sku: sku)
        producto[:precio] = cola[:precio]
      else
        producto[:precio] = HttpManager.get_precio(sku: sku, fecha: DateTime.now.strftime("%Y-%m-%d"))[:Precio]
      end
      producto.save
    end
  end

  def self.insumos_necesarios
    insumos_necesarios = [
      {'sku_final' => '4', 'cant_lote' => 200, 'sku_insumo' => '38', 'requerimiento' => 190},
      {'sku_final' => '5', 'cant_lote' => 600, 'sku_insumo' => '49', 'requerimiento' => 228},
      {'sku_final' => '5', 'cant_lote' => 600, 'sku_insumo' => '6', 'requerimiento' => 228},
      {'sku_final' => '5', 'cant_lote' => 600, 'sku_insumo' => '41', 'requerimiento' => 194},
      {'sku_final' => '6', 'cant_lote' => 30, 'sku_insumo' => '49', 'requerimiento' => -270},
      {'sku_final' => '6', 'cant_lote' => 30, 'sku_insumo' => '7', 'requerimiento' => 300},
      {'sku_final' => '10', 'cant_lote' => 900, 'sku_insumo' => '23', 'requerimiento' => 342},
      {'sku_final' => '10', 'cant_lote' => 900, 'sku_insumo' => '26', 'requerimiento' => 309},
      {'sku_final' => '10', 'cant_lote' => 900, 'sku_insumo' => '27', 'requerimiento' => 279},
      {'sku_final' => '11', 'cant_lote' => 900, 'sku_insumo' => '4', 'requerimiento' => 828},
      {'sku_final' => '12', 'cant_lote' => 400, 'sku_insumo' => '25', 'requerimiento' => 133.3333333},
      {'sku_final' => '12', 'cant_lote' => 400, 'sku_insumo' => '20', 'requerimiento' => 146.6666667},
      {'sku_final' => '12', 'cant_lote' => 400, 'sku_insumo' => '15', 'requerimiento' => 113.3333333},
      {'sku_final' => '16', 'cant_lote' => 1000, 'sku_insumo' => '23', 'requerimiento' => 330},
      {'sku_final' => '16', 'cant_lote' => 1000, 'sku_insumo' => '26', 'requerimiento' => 313.3333333},
      {'sku_final' => '16', 'cant_lote' => 1000, 'sku_insumo' => '2', 'requerimiento' => 383.3333333},
      {'sku_final' => '17', 'cant_lote' => 1000, 'sku_insumo' => '25', 'requerimiento' => 360},
      {'sku_final' => '17', 'cant_lote' => 1000, 'sku_insumo' => '20', 'requerimiento' => 350},
      {'sku_final' => '17', 'cant_lote' => 1000, 'sku_insumo' => '13', 'requerimiento' => 290},
      {'sku_final' => '18', 'cant_lote' => 200, 'sku_insumo' => '23', 'requerimiento' => 72},
      {'sku_final' => '18', 'cant_lote' => 200, 'sku_insumo' => '2', 'requerimiento' => 71.33333333},
      {'sku_final' => '18', 'cant_lote' => 200, 'sku_insumo' => '7', 'requerimiento' => 66.66666667},
      {'sku_final' => '22', 'cant_lote' => 400, 'sku_insumo' => '6', 'requerimiento' => 380},
      {'sku_final' => '23', 'cant_lote' => 300, 'sku_insumo' => '8', 'requerimiento' => 309},
      {'sku_final' => '24', 'cant_lote' => 400, 'sku_insumo' => '33', 'requerimiento' => 444},
      {'sku_final' => '28', 'cant_lote' => 500, 'sku_insumo' => '37', 'requerimiento' => 440},
      {'sku_final' => '29', 'cant_lote' => 400, 'sku_insumo' => '31', 'requerimiento' => 368},
      {'sku_final' => '30', 'cant_lote' => 500, 'sku_insumo' => '21', 'requerimiento' => 460},
      {'sku_final' => '34', 'cant_lote' => 700, 'sku_insumo' => '14', 'requerimiento' => 332.5},
      {'sku_final' => '34', 'cant_lote' => 700, 'sku_insumo' => '27', 'requerimiento' => 318.5},
      {'sku_final' => '35', 'cant_lote' => 500, 'sku_insumo' => '44', 'requerimiento' => 430},
      {'sku_final' => '36', 'cant_lote' => 100, 'sku_insumo' => '45', 'requerimiento' => 89},
      {'sku_final' => '40', 'cant_lote' => 900, 'sku_insumo' => '7', 'requerimiento' => 1000},
      {'sku_final' => '40', 'cant_lote' => 900, 'sku_insumo' => '41', 'requerimiento' => -100},
      {'sku_final' => '41', 'cant_lote' => 200, 'sku_insumo' => '7', 'requerimiento' => 2000},
      {'sku_final' => '41', 'cant_lote' => 200, 'sku_insumo' => '40', 'requerimiento' => -1800},
      {'sku_final' => '42', 'cant_lote' => 200, 'sku_insumo' => '25', 'requerimiento' => 66.66666667},
      {'sku_final' => '42', 'cant_lote' => 200, 'sku_insumo' => '20', 'requerimiento' => 71.33333333},
      {'sku_final' => '42', 'cant_lote' => 200, 'sku_insumo' => '3', 'requerimiento' => 68.66666667},
      {'sku_final' => '46', 'cant_lote' => 800, 'sku_insumo' => '20', 'requerimiento' => 296},
      {'sku_final' => '46', 'cant_lote' => 800, 'sku_insumo' => '25', 'requerimiento' => 269.3333333},
      {'sku_final' => '46', 'cant_lote' => 800, 'sku_insumo' => '7', 'requerimiento' => 250.6666667},
      {'sku_final' => '47', 'cant_lote' => 1000, 'sku_insumo' => '39', 'requerimiento' => 495},
      {'sku_final' => '47', 'cant_lote' => 1000, 'sku_insumo' => '27', 'requerimiento' => 570},
      {'sku_final' => '47', 'cant_lote' => 1000, 'sku_insumo' => '25', 'requerimiento' => 1000},
      {'sku_final' => '48', 'cant_lote' => 500, 'sku_insumo' => '19', 'requerimiento' => 160},
      {'sku_final' => '48', 'cant_lote' => 500, 'sku_insumo' => '26', 'requerimiento' => 171.6666667},
      {'sku_final' => '48', 'cant_lote' => 500, 'sku_insumo' => '2', 'requerimiento' => 155},
      {'sku_final' => '49', 'cant_lote' => 200, 'sku_insumo' => '7', 'requerimiento' => 222.2222222},
    {'sku_final' => '49', 'cant_lote' => 200, 'sku_insumo' => '6', 'requerimiento' => -22.22222222}]
  end


  def self.get_nombre(sku)
    return get_datos_sku(sku)[:nombre]
  end

  def self.get_categoria(sku)
    return get_datos_sku(sku)[:categoria]
  end

  def self.get_datos_sku(sku)
    datos_base = {
      '1' => {:proveedor => 1, :costo => 1270, :tipo => 'insumo', :nombre => 'Pollo', :categoria => 'CARNES Y HUEVOS'},
      '2' => { :proveedor => 7, :costo => 1289, :tipo => 'insumo', :nombre => 'Huevo', :categoria => 'CARNES Y HUEVOS'},
      '3' => { :proveedor => 7, :costo => 1370, :tipo => 'insumo', :nombre => 'Maíz', :categoria => 'CEREALES Y LEGUMBRES'},
      '4' => { :proveedor => 1, :costo => 1732, :tipo => 'compuesto', :nombre => 'Aceite de Maravilla', :categoria => 'ACEITES Y GRASAS'},
      '5' => { :proveedor => 5, :costo => 600, :tipo => 'compuesto', :nombre => 'Yogur', :categoria => 'LECHES Y DERIVADOS'},
      '6' => { :proveedor => 1, :costo => 6453, :tipo => 'compuesto', :nombre => 'Crema', :categoria => 'LECHES Y DERIVADOS'},
      '7' => { :proveedor => 6, :costo => 1696, :tipo => 'insumo', :nombre => 'Leche', :categoria => 'LECHES Y DERIVADOS'},
      '8' => { :proveedor => 2, :costo => 3891, :tipo => 'insumo', :nombre => 'Trigo', :categoria => 'CEREALES Y LEGUMBRES'},
      '9' => { :proveedor => 2, :costo => 2640, :tipo => 'insumo', :nombre => 'Carne', :categoria => 'CARNES Y HUEVOS'},
      '10' => { :proveedor => 2, :costo => 2523, :tipo => 'compuesto', :nombre => 'Pan', :categoria => 'CEREALES Y LEGUMBRES'},
      '11' => { :proveedor => 7, :costo => 2003, :tipo => 'compuesto', :nombre => 'Margarina ', :categoria => 'ACEITES Y GRASAS'},
      '12' => { :proveedor => 2, :costo => 1829, :tipo => 'compuesto', :nombre => 'Cereal Arroz ', :categoria => 'CEREALES Y LEGUMBRES'},
      '13' => { :proveedor => 4, :costo => 2780, :tipo => 'insumo', :nombre => 'Arroz', :categoria => 'CEREALES Y LEGUMBRES'},
      '14' => { :proveedor => 3, :costo => 3673, :tipo => 'insumo', :nombre => 'Cebada', :categoria => 'CEREALES Y LEGUMBRES'},
      '15' => { :proveedor => 3, :costo => 3660, :tipo => 'insumo', :nombre => 'Avena', :categoria => 'CEREALES Y LEGUMBRES'},
      '16' => { :proveedor => 3, :costo => 1251, :tipo => 'compuesto', :nombre => 'Pasta de Trigo', :categoria => 'CEREALES Y LEGUMBRES'},
      '17' => { :proveedor => 3, :costo => 2602, :tipo => 'compuesto', :nombre => 'Cereal Arroz', :categoria => 'CEREALES Y LEGUMBRES'},
      '18' => { :proveedor => 3, :costo => 3518, :tipo => 'compuesto', :nombre => 'Pastel', :categoria => 'CEREALES Y LEGUMBRES'},
      '19' => { :proveedor => 4, :costo => 1917, :tipo => 'insumo', :nombre => 'Sémola', :categoria => 'CEREALES Y LEGUMBRES'},
      '20' => { :proveedor => 3, :costo => 3953, :tipo => 'insumo', :nombre => 'Cacao', :categoria => 'DULCE'},
      '21' => { :proveedor => 4, :costo => 2203, :tipo => 'insumo', :nombre => 'Algodón', :categoria => 'TELAS'},
      '22' => { :proveedor => 4, :costo => 2629, :tipo => 'compuesto', :nombre => 'Mantequilla', :categoria => 'ACEITES Y GRASAS'},
      '23' => { :proveedor => 4, :costo => 2747, :tipo => 'compuesto', :nombre => 'Harina', :categoria => 'CEREALES Y LEGUMBRES'},
      '24' => { :proveedor => 4, :costo => 1988, :tipo => 'compuesto', :nombre => 'Tela de Seda', :categoria => 'TELAS'},
      '25' => { :proveedor => 8, :costo => 1588, :tipo => 'insumo', :nombre => 'Azúcar', :categoria => 'OTRO'},
      '26' => { :proveedor => 5, :costo => 1946, :tipo => 'insumo', :nombre => 'Sal', :categoria => 'MINERAL'},
      '27' => { :proveedor => 5, :costo => 631, :tipo => 'insumo', :nombre => 'Levadura', :categoria => 'OTRO'},
      '28' => { :proveedor => 5, :costo => 1069, :tipo => 'compuesto', :nombre => 'Tela de Lino', :categoria => 'TELAS'},
      '29' => { :proveedor => 5, :costo => 3988, :tipo => 'compuesto', :nombre => 'Tela de Lana', :categoria => 'TELAS'},
      '30' => { :proveedor => 5, :costo => 1390, :tipo => 'compuesto', :nombre => 'Tela de Algodón', :categoria => 'TELAS'},
      '31' => { :proveedor => 1, :costo => 979, :tipo => 'insumo', :nombre => 'Lana', :categoria => 'TELAS'},
      '32' => { :proveedor => 1, :costo => 1252, :tipo => 'insumo', :nombre => 'Cuero', :categoria => 'TELAS'},
      '33' => { :proveedor => 6, :costo => 3332, :tipo => 'insumo', :nombre => 'Seda', :categoria => 'TELAS'},
      '34' => { :proveedor => 6, :costo => 891, :tipo => 'compuesto', :nombre => 'Cerveza', :categoria => 'ALCOHOL'},
      '35' => { :proveedor => 6, :costo => 3375, :tipo => 'compuesto', :nombre => 'Tequila', :categoria => 'ALCOHOL'},
      '36' => { :proveedor => 6, :costo => 2052, :tipo => 'compuesto', :nombre => 'Papel', :categoria => 'OTRO'},
      '37' => { :proveedor => 2, :costo => 2363, :tipo => 'insumo', :nombre => 'Lino', :categoria => 'TELAS'},
      '38' => { :proveedor => 2, :costo => 2041, :tipo => 'insumo', :nombre => 'Semillas Maravilla', :categoria => 'SEMILLAS'},
      '39' => { :proveedor => 2, :costo => 3111, :tipo => 'insumo', :nombre => 'Uva', :categoria => 'FRUTA'},
      '40' => { :proveedor => 7, :costo => 3299, :tipo => 'compuesto', :nombre => 'Queso', :categoria => 'LECHES Y DERIVADOS'},
      '41' => { :proveedor => 7, :costo => 29691, :tipo => 'compuesto', :nombre => 'Suero de Leche', :categoria => 'LECHES Y DERIVADOS'},
      '42' => { :proveedor => 2, :costo => 3446, :tipo => 'compuesto', :nombre => 'Cereal Maíz', :categoria => 'CEREALES Y LEGUMBRES'},
      '43' => { :proveedor => 8, :costo => 1297, :tipo => 'insumo', :nombre => 'Madera', :categoria => 'OTRO'},
      '44' => { :proveedor => 5, :costo => 3043, :tipo => 'insumo', :nombre => 'Agave', :categoria => 'OTRO'},
      '45' => { :proveedor => 8, :costo => 2646, :tipo => 'insumo', :nombre => 'Celulosa', :categoria => 'OTRO'},
      '46' => { :proveedor => 8, :costo => 1031, :tipo => 'compuesto', :nombre => 'Chocolate', :categoria => 'OTRO'},
      '47' => { :proveedor => 1, :costo => 1496, :tipo => 'compuesto', :nombre => 'Vino', :categoria => 'ALCOHOL'},
      '48' => { :proveedor => 8, :costo => 3256, :tipo => 'compuesto', :nombre => 'Pasta de Sémola', :categoria => 'CEREALES Y LEGUMBRES'},
      '49' => { :proveedor => 1, :costo => 717, :tipo => 'compuesto', :nombre => 'Leche Descremada', :categoria => 'LECHES Y DERIVADOS'}
    }
    return datos_base[sku]
  end

end
