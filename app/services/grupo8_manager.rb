class Grupo8Manager
  # params = { group: , order_id: }
  def self.new_order(params)
    order_id = params[:order_id]
    bodega_id = params[:bodega_id]

    url = uri + 'new_order/'
    request_params = {
      order_id: order_id,
      bodega_id: bodega_id
    }
    return response = HTTParty.post(url, :body => request_params.to_json , headers: headers)
  end


  # params = { group: 3, order_id: "123j234oiu" }
  def self.order_accepted(params)
    order_id = params[:order_id]
    url = uri + 'order_accepted/'
    request_params = {
      order_id: order_id
    }
    return response = HTTParty.post(url, :body => request_params.to_json , headers: headers)
  end


  # params = { group: 3, order_id: "123j234oiu" }
  def self.order_canceled(params)
    order_id = params[:order_id]
    url = uri + 'order_canceled/'
    request_params = {
      order_id: order_id
    }
    return response = HTTParty.post(url, :body => request_params.to_json , headers: headers)
  end


  # params = { group: 3, order_id: "123j234oiu" }
  def self.order_rejected(params)
    order_id = params[:order_id]
    url = uri + 'order_rejected/'
    request_params = {
      order_id: order_id
    }
    return response = HTTParty.post(url, :body => request_params.to_json , headers: headers)
  end


  # params = { group: 3, order_id: "123j234oiu" }
  def self.invoice_created(params)
    invoice_id = params[:invoice_id]
    url = uri + 'invoice_created/'
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
    return response = HTTParty.post(url, :body => request_params.to_json , headers: headers)
  end

  def self.invoice_rejected(params)
    invoice_id = params[:invoice_id]
    url = uri + 'invoice_rejected/'
    request_params = {
      invoice_id: invoice_id
    }
    return response = HTTParty.post(url, :body => request_params.to_json , headers: headers)
  end



  # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

  def self.uri
    'http://integra8.ing.puc.cl/b2b/'
  end

  def self.headers(for_token)
    if for_token
      response = { 
        'Content-Type' => 'application/json', 
        'Accept' => 'application/json'
      }
    else
      response = { 
        'Content-Type' => 'application/json', 
        'Accept' => 'application/json',
        'Authorization' => 'Token ' + token
      }
    end

    return response
  end

  def self.token
    url = uri + 'get_token/'
    request_params = {
      username: 'grupo5',
      password: 'grupo5grupo5'

    }
    response = HTTParty.post(url, :body => request_params.to_json , headers: headers(true))
    response["token"]
  end

end