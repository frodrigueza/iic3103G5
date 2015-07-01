class GruposManager
  # params = { group: , order_id: }
  def self.new_order(params) 
    case params[:group]
    when "1"
      Grupo1Manager.new_order(params)
    when "2"
      Grupo2Manager.new_order(params)
    when "3"
      Grupo3Manager.new_order(params)
    when "4"
      Grupo4Manager.new_order(params)
    when "5"
      Grupo5Manager.new_order(params)
    when "6"
      Grupo6Manager.new_order(params)
    when "7"
      Grupo7Manager.new_order(params)
    when "8"
      Grupo8Manager.new_order(params)
    end

    rescue
      nil
  end
  # params = { group: , order_id: }
  def self.order_accepted(params)
    case params[:group]
    when "1"
      Grupo1Manager.order_accepted(params)
    when "2"
      Grupo2Manager.order_accepted(params)
    when "3"
      Grupo3Manager.order_accepted(params)
    when "4"
      Grupo4Manager.order_accepted(params)
    when "5"
      Grupo5Manager.order_accepted(params)
    when "6"
      Grupo6Manager.order_accepted(params)
    when "7"
      Grupo7Manager.order_accepted(params)
    when "8"
      Grupo8Manager.order_accepted(params)
    end

    rescue
      nil
  end


  # params = { group: , order_id: }
  def self.order_canceled(params)
    case params[:group]
    when "1"
      Grupo1Manager.order_canceled(params)
    when "2"
      Grupo2Manager.order_canceled(params)
    when "3"
      Grupo3Manager.order_canceled(params)
    when "4"
      Grupo4Manager.order_canceled(params)
    when "5"
      Grupo5Manager.order_canceled(params)
    when "6"
      Grupo6Manager.order_canceled(params)
    when "7"
      Grupo7Manager.order_canceled(params)
    when "8"
      Grupo8Manager.order_canceled(params)
    end

    rescue
      nil
  end



  # params = { group: , order_id: }
  def self.order_rejected(params)
    case params[:group]
    when "1"
      Grupo1Manager.order_rejected(params)
    when "2"
      Grupo2Manager.order_rejected(params)
    when "3"
      Grupo3Manager.order_rejected(params)
    when "4"
      Grupo4Manager.order_rejected(params)
    when "5"
      Grupo5Manager.order_rejected(params)
    when "6"
      Grupo6Manager.order_rejected(params)
    when "7"
      Grupo7Manager.order_rejected(params)
    when "8"
      Grupo8Manager.order_rejected(params)
    end

    rescue
      nil
  end



  # params = { group: , invoice_id: }
  def self.invoice_created(params)
    case params[:group]
    when "1"
      Grupo1Manager.invoice_created(params)
    when "2"
      Grupo2Manager.invoice_created(params)
    when "3"
      Grupo3Manager.invoice_created(params)
    when "4"
      Grupo4Manager.invoice_created(params)
    when "5"
      Grupo5Manager.invoice_created(params)
    when "6"
      Grupo6Manager.invoice_created(params)
    when "7"
      Grupo7Manager.invoice_created(params)
    when "8"
      Grupo8Manager.invoice_created(params)
    end

    rescue
      nil
  end


  # params = { group: , invoice_id: }
  def self.invoice_paid(params)
    case params[:group]
    when "1"
      Grupo1Manager.invoice_paid(params)
    when "2"
      Grupo2Manager.invoice_paid(params)
    when "3"
      Grupo3Manager.invoice_paid(params)
    when "4"
      Grupo4Manager.invoice_paid(params)
    when "5"
      Grupo5Manager.invoice_paid(params)
    when "6"
      Grupo6Manager.invoice_paid(params)
    when "7"
      Grupo7Manager.invoice_paid(params)
    when "8"
      Grupo8Manager.invoice_paid(params)
    end

    rescue
      nil
  end


  # params = { group: , invoice_id: }
  def self.invoice_rejected(params)
    case params[:group]
    when "1"
      Grupo1Manager.invoice_rejected(params)
    when "2"
      Grupo2Manager.invoice_rejected(params)
    when "3"
      Grupo3Manager.invoice_rejected(params)
    when "4"
      Grupo4Manager.invoice_rejected(params)
    when "5"
      Grupo5Manager.invoice_rejected(params)
    when "6"
      Grupo6Manager.invoice_rejected(params)
    when "7"
      Grupo7Manager.invoice_rejected(params)
    when "8"
      Grupo8Manager.invoice_rejected(params)
    end

    rescue
      nil
  end

  def self.get_token(group)
    case group
      when "1"
        return 'Z3J1cG81Z3J1cG81Z3J1cG81'
      when "2"
        return '$2a$10$Igddu9rHAEAXbXsPPP785ucuoOaJx58UT64jdc9ZnxIq/c0wNFtCy'
      when "3"
        return 'c552387c256127ea5c25d94a6204ad61d3c504a5'
      when "4"
        return '2b783b907e446daa64bbc852cd902648'
      when "5"
        return ''
      when "6"
        return '0da70c1afdc0c212cd81f3d5ba613605'
      when "7"
        return 'f67ecf9cdebc86512cc93a6149eadbc3'
      when "8"
        return Grupo8Manager.token
    end

    rescue
      nil
  end


  # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

end