class GroupInfo

  @@produccion = true

  def self.en_produccion
    return @@produccion
  end

  # skus que trabaja la empresa
  # insumo= 26,27,44 compuesto= 5,28,29,30
  def self.skus
    %w[5 26 27 28 29 30 44]
  end

  def self.id
  	return "55648ad2f89fed0300524ff9" if @@produccion
    return "556489daefb3d7030091baae" if not @@produccion
  end

  def self.grupo 
    return "5"
  end

  def self.cuenta_banco
    return "55648ad3f89fed0300524ffd" if @@produccion
  	return "556489daefb3d7030091bab2" if not @@produccion
  end

  def self.clave_bodega
    return "ewITW8H8qGf5m1E" if @@produccion
  	return "0c0ifZEBkDKnsb" if not @@produccion
  end

  def self.clave_servidor
  	return "M8yF.3@Pd"
  end

  def self.cuenta_banco_fabrica
    return "55648ad2f89fed0300524ff3" if @@produccion
  	return "556489daefb3d7030091baa8" if not @@produccion
  end

  def self.almacen_recepcion
    return "55648ae7f89fed0300525219" if @@produccion
  	return "556489e7efb3d7030091bdcc" if not @@produccion
  end

  def self.almacen_despacho
    return "55648ae7f89fed030052521a" if @@produccion
  	return "556489e7efb3d7030091bdcd" if not @@produccion
  end

  def self.almacen_pulmon
    return "55648ae7f89fed0300525292" if @@produccion
  	return "556489e7efb3d7030091bf2a" if not @@produccion
  end

  def self.almacen_libre
    return "55648ae7f89fed030052521b" if @@produccion
  	return "556489e7efb3d7030091bdce" if not @@produccion
  end

  def self.almacen_devoluciones
    return "55648ae7f89fed0300525291" if @@produccion
  	return "556489e7efb3d7030091bf29" if not @@produccion
  end

  def self.url_api_curso
    return 'http://moyas.ing.puc.cl:8080/grupo5/webresources/' if @@produccion
    return 'http://chiri.ing.puc.cl:8080/grupo5/webresources/' if not @@produccion
  end

  def self.url_api_bodega
    return 'http://integracion-2015-prod.herokuapp.com/bodega/' if @@produccion
    return 'http://integracion-2015-dev.herokuapp.com/bodega/' if not @@produccion
  end

  def self.url_ftp
    return 'moyas.ing.puc.cl'if @@produccion
    return 'chiri.ing.puc.cl'if not @@produccion
  end

  def self.url_esb
    return 'http://moyas.ing.puc.cl/integra5/' if @@produccion
    return 'http://chiri.ing.puc.cl/integra5/' if not @@produccion
  end

  def self.url_cola
    return 'amqp://zioohigg:f31hQpoYF3Lbv1g2ms93swBGU22x1y_C@owl.rmq.cloudamqp.com/zioohigg' if @@produccion
    return 'amqp://wdbztoic:uglKVZNnHmwzvbGHM92I9ugVuaHyT9f3@owl.rmq.cloudamqp.com/wdbztoic' if not @@produccion
  end

  def self.ig_access_token
    return '2049758554.1fb234f.540af7caceca41cdbe122d62addd7826'    
  end

  def self.url_pago_en_linea
    return 'http://moyas.ing.puc.cl/banco/pagoenlinea' if @@produccion
    return 'http://chiri.ing.puc.cl/banco/pagoenlinea' if not @@produccion
  end

  def self.clave_ecommerce
      return 'Hy:RksMp' if @@produccion
      return '@qvtvLhh' if not @@produccion
    end


end
