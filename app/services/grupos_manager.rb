class GruposManager
  # params = { group: , order_id: }
  def self.new_order(params)
    case params[:group]
    when 1
      GrupoUnoManager.new_order(params)
    when 2
      GrupoDosManager.new_order(params)
    when 3
      GrupoTresManager.new_order(params)
    when 4
      GrupoCuatroManager.new_order(params)
    when 5
      Grupo5Manager.new_order(params)
    when 6
      GrupoSeisManager.new_order(params)
    when 7
      GrupoSieteManager.new_order(params)
    when 8
      GrupoOchoManager.new_order(params)
    end
  end
  # params = { group: , order_id: }
  def self.order_accepted(params)
    case params[:group]
    when 1
      GrupoUnoManager.order_accepted(params)
    when 2
      GrupoDosManager.order_accepted(params)
    when 3
      GrupoTresManager.order_accepted(params)
    when 4
      GrupoCuatroManager.order_accepted(params)
    when 5
      Grupo5Manager.order_accepted(params)
    when 6
      GrupoSeisManager.order_accepted(params)
    when 7
      GrupoSieteManager.order_accepted(params)
    when 8
      GrupoOchoManager.order_accepted(params)
    end
  end


  # params = { group: , order_id: }
  def self.order_canceled(params)
    case params[:group]
    when 1
      GrupoUnoManager.order_canceled(params)
    when 2
      GrupoDosManager.order_canceled(params)
    when 3
      GrupoTresManager.order_canceled(params)
    when 4
      GrupoCuatroManager.order_canceled(params)
    when 5
      Grupo5Manager.order_canceled(params)
    when 6
      GrupoSeisManager.order_canceled(params)
    when 7
      GrupoSieteManager.order_canceled(params)
    when 8
      GrupoOchoManager.order_canceled(params)
    end
  end



  # params = { group: , order_id: }
  def self.order_rejected(params)
    case params[:group]
    when 1
      GrupoUnoManager.order_rejected(params)
    when 2
      GrupoDosManager.order_rejected(params)
    when 3
      GrupoTresManager.order_rejected(params)
    when 4
      GrupoCuatroManager.order_rejected(params)
    when 5
      Grupo5Manager.order_rejected(params)
    when 6
      GrupoSeisManager.order_rejected(params)
    when 7
      GrupoSieteManager.order_rejected(params)
    when 8
      GrupoOchoManager.order_rejected(params)
    end
  end



  # params = { group: , order_id: }
  def self.invoice_created(params)
    case params[:group]
    when 1
      GrupoUnoManager.invoice_created(params)
    when 2
      GrupoDosManager.invoice_created(params)
    when 3
      GrupoTresManager.invoice_created(params)
    when 4
      GrupoCuatroManager.invoice_created(params)
    when 5
      Grupo5Manager.invoice_created(params)
    when 6
      GrupoSeisManager.invoice_created(params)
    when 7
      GrupoSieteManager.invoice_created(params)
    when 8
      GrupoOchoManager.invoice_created(params)
    end
  end


  # params = { group: , order_id: }
  def self.invoice_paid(params)
    case params[:group]
    when 1
      GrupoUnoManager.invoice_paid(params)
    when 2
      GrupoDosManager.invoice_paid(params)
    when 3
      GrupoTresManager.invoice_paid(params)
    when 4
      GrupoCuatroManager.invoice_paid(params)
    when 5
      Grupo5Manager.invoice_paid(params)
    when 6
      GrupoSeisManager.invoice_paid(params)
    when 7
      GrupoSieteManager.invoice_paid(params)
    when 8
      GrupoOchoManager.invoice_paid(params)
    end
  end


  # params = { group: , order_id: }
  def self.invoice_rejected(params)
    case params[:group]
    when 1
      GrupoUnoManager.invoice_rejected(params)
    when 2
      GrupoDosManager.invoice_rejected(params)
    when 3
      GrupoTresManager.invoice_rejected(params)
    when 4
      GrupoCuatroManager.invoice_rejected(params)
    when 5
      Grupo5Manager.invoice_rejected(params)
    when 6
      GrupoSeisManager.invoice_rejected(params)
    when 7
      GrupoSieteManager.invoice_rejected(params)
    when 8
      GrupoOchoManager.invoice_rejected(params)
    end
  end

  def self.get_token(params)
    group = params[:group]

    case group
      when 1
        return 'Z3J1cG81Z3J1cG81Z3J1cG81'
      when 2
        return '$2a$10$Igddu9rHAEAXbXsPPP785ucuoOaJx58UT64jdc9ZnxIq/c0wNFtCy'
      when 3
        return 'c552387c256127ea5c25d94a6204ad61d3c504a5'
      when 4
        return '2b783b907e446daa64bbc852cd902648'
      when 5
        return ''
      when 6
        return '0da70c1afdc0c212cd81f3d5ba613605'
      when 7
        return 'f67ecf9cdebc86512cc93a6149eadbc3'
      when 8
        return GrupoOchoManager.token
    end
  end


  # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

end