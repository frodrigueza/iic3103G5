class Grupo4Manager
  # params = { group: , order_id: }
  def self.new_order(params)
    order_id = params[:order_id]

    url = uri + 'new_order.json'
    request_params = {
      order_id: order_id
    }
    return response = HTTParty.get(url, :body => request_params.to_json , headers: headers)
  end


  # params = { group: 3, order_id: "123j234oiu" }
  def self.order_accepted(params)
    order_id = params[:order_id]
    url = uri + 'order_accepted.json'
    request_params = {
      order_id: order_id,
      token: token
    }
    return response = HTTParty.get(url, :body => request_params.to_json , headers: headers)
  end


  # params = { group: 3, order_id: "123j234oiu" }
  def self.order_canceled(params)
    order_id = params[:order_id]
    url = uri + 'order_canceled.json'
    request_params = {
      order_id: order_id,
      token: token
    }
    return response = HTTParty.get(url, :body => request_params.to_json , headers: headers)
  end


  # params = { group: 3, order_id: "123j234oiu" }
  def self.order_rejected(params)
    order_id = params[:order_id]
    url = uri + 'order_rejected.json'
    request_params = {
      order_id: order_id,
      token: token
    }
    return response = HTTParty.get(url, :body => request_params.to_json , headers: headers)
  end


  # params = { group: 3, order_id: "123j234oiu" }
  def self.invoice_created(params)
    invoice_id = params[:invoice_id]
    url = uri + 'invoice_created.json'
    request_params = {
      invoice_id: invoice_id,
      token: token
    }
    return response = HTTParty.get(url, :body => request_params.to_json , headers: headers)
  end

  # params = { group: 3, order_id: "123j234oiu" }
  def self.invoice_paid(params)
    invoice_id = params[:invoice_id]
    url = uri + 'invoice_paid.json'
    request_params = {
      invoice_id: invoice_id,
      token: token
    }
    return response = HTTParty.get(url, :body => request_params.to_json , headers: headers)
  end

  def self.invoice_rejected(params)
    invoice_id = params[:invoice_id]
    url = uri + 'invoice_rejected.json'
    request_params = {
      invoice_id: invoice_id,
      token: token
    }
    return response = HTTParty.get(url, :body => request_params.to_json , headers: headers)
  end



  # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

  def uri
    'http://integra4.ing.puc.cl/b2b/'
  end

  def self.headers
	  response = { 
	    'Content-Type' => 'application/json', 
	    'Accept' => 'application/json',
	    'Authorization' => 'Token ' + token
	  }

    return response
  end

  def token
  	GruposManager.get_token(4)
  end

end