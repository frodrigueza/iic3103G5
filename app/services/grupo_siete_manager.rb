class GrupoSieteManager
  # params = { group: , order_id: }
  def self.new_order(params)
    order_id = params[:order_id]

    url = uri + 'create_order/'
    request_params = {
      order_id: order_id
    }
    return response = HTTParty.post(url, :body => request_params.to_json , headers: headers)
  end


  # params = { group: 3, order_id: "123j234oiu" }
  def self.order_accepted(params)
    order_id = params[:order_id]
    url = uri + 'accepted_order/'
    request_params = {
      order_id: order_id
    }
    return response = HTTParty.put(url, :body => request_params.to_json , headers: headers)
  end


  # params = { group: 3, order_id: "123j234oiu" }
  def self.order_canceled(params)
    order_id = params[:order_id]
    url = uri + 'canceled_order/'
    request_params = {
      order_id: order_id
    }
    return response = HTTParty.delete(url, :body => request_params.to_json , headers: headers)
  end


  # params = { group: 3, order_id: "123j234oiu" }
  def self.order_rejected(params)
    order_id = params[:order_id]
    url = uri + 'rejected_order/'
    request_params = {
      order_id: order_id
    }
    return response = HTTParty.put(url, :body => request_params.to_json , headers: headers)
  end


  # params = { group: 3, order_id: "123j234oiu" }
  def self.invoice_created(params)
    invoice_id = params[:invoice_id]
    url = uri + 'issued_invoice/'
    request_params = {
      invoice_id: invoice_id
    }
    return response = HTTParty.post(url, :body => request_params.to_json , headers: headers)
  end

  # params = { group: 3, order_id: "123j234oiu" }
  def self.invoice_paid(params)
    invoice_id = params[:invoice_id]
    url = uri + 'invoice_paid/'
    request_params = {
      invoice_id: invoice_id
    }
    return response = HTTParty.put(url, :body => request_params.to_json , headers: headers)
  end

  def self.invoice_rejected(params)
    invoice_id = params[:invoice_id]
    url = uri + 'rejected_invoice/'
    request_params = {
      invoice_id: invoice_id
    }
    return response = HTTParty.put(url, :body => request_params.to_json , headers: headers)
  end



  # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

  def uri
    'http://integra7.ing.puc.cl/api/'
  end

  def self.headers
	  response = { 
	    'Content-Type' => 'application/json', 
	    'Accept' => 'application/json',
	    'authorization' => token
	  }

    return response
  end

  def self.token
  	GruposManager.get_token(7)
  end

end