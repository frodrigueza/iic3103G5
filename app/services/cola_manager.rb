class ColaManager

  def self.recibir

    conn = Bunny.new(GroupInfo.url_cola)
    conn.start

    ch   = conn.create_channel
    q    = ch.queue("ofertas", :auto_delete => true)

    delivery_info, metadata, payload = q.pop

    if (payload != nil)

      mensaje = JSON.parse(payload)

      mensaje = mensaje.symbolize_keys

      #verificamos si sku 5,26,27,28,29,30,4	4. Como el mensaje es un string verificamos
      #que cotenga por ejemplo "sku":"3" <- Formato correspondiente

      if GroupInfo.skus.include? mensaje[:sku]
        inicio = Time.at((mensaje[:inicio].to_i)/1000).to_datetime
		fin = Time.at((mensaje[:fin].to_i)/1000).to_datetime
        sku = mensaje[:sku]
        precio = mensaje[:precio]
        Cola.create(inicio: inicio, fin: fin, sku: sku, precio: precio)
        mensaje_tweeter = "OFERTA COLA! Sku: #{sku} a sólo #{precio}. Desde:#{inicio}, hasta: #{fin}"
        body = {:tweet => mensaje_tweeter}
        HttpManager.tweet(body)
        #Parámetros que vienen en la cola: numero_sku, precio, fecha_init, fecha_fin
      end
    end
    conn.close
  end
end
