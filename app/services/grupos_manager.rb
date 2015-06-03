class GruposManager
  # params = { group: , order_id: }
  def self.new_order(params)
    group = params[:group]
    order_id = params[:order_id]

    case group
      when 1,2,3,4,5,6,7,8,9
        url = uri(group) + 'new_order/'
        request_params = {
          order_id: order_id
        }
        return response = HTTParty.post(url, :body => request_params.to_json , headers: headers(group))
    end
  end


  # params = { group: 3, order_id: "123j234oiu" }
  def self.order_accepted(params)
    group = params[:group]
    order_id = params[:order_id]

    case group
      when 1,2,3,4,5,6,7,8
        url = uri(group) + 'order_accepted/'
        request_params = {
          order_id: order_id
        }
        return response = HTTParty.post(url, :body => request_params.to_json , headers: headers(group))
    end
  end

  def self.get_token(params)
    group = params[:group]

    case group
      when 1,2,3,4,5,6,7,8
        url = uri(group) + 'get_token/'
        request_params = {
          username: username(group),
          password: password(group)
        }
        response = HTTParty.post(url, :body => request_params.to_json , :headers =>{ 'Content-Type' => 'application/json', 'Accept' => 'application/json'})
        return response.parsed_response["token"]
      else
        nil
    end
  end



  # params = { group: 3, order_id: "123j234oiu" }
  def self.order_canceled(params)
    group = params[:group]
    order_id = params[:order_id]

    case group
      when 1,2,3,4,5,6,7,8
        url = uri(group) + 'order_canceled/'
        request_params = {
          order_id: order_id
        }
        return response = HTTParty.post(url, :body => request_params.to_json , headers: headers(group))
    end
  end

  # params = { group: 3, order_id: "123j234oiu" }
  def self.order_rejected(params)
    group = params[:group]
    order_id = params[:order_id]

    case group
      when 1,2,3,4,5,6,7,8
        url = uri(group) + 'order_rejected/'
        request_params = {
          order_id: order_id
        }
        return response = HTTParty.post(url, :body => request_params.to_json , headers: headers(group))
    end
  end

  # params = { group: 3, invoice_id: "123j234oiu" }
  def self.invoice_created(params)
    group = params[:group]
    invoice_id = params[:invoice_id]

    case group
      when 1,2,3,4,5,6,7,8
        url = uri(group) + 'invoice_created/'
        request_params = {
          invoice_id: invoice_id
        }
        return response = HTTParty.post(url, :body => request_params.to_json , headers: headers(group))
    end
  end

  # params = { group: 3, invoice_id: "123j234oiu" }
  def self.invoice_paid(params)
    group = params[:group]
    invoice_id = params[:invoice_id]

    case group
      when 1,2,3,4,5,6,7,8
        url = uri(group) + 'invoice_paid/'
        request_params = {
          invoice_id: invoice_id
        }
        return response = HTTParty.post(url, :body => request_params.to_json , headers: headers(group))
    end
  end

  # params = { group: 3, invoice_id: "123j234oiu" }
  def self.invoice_rejected(params)
    group = params[:group]
    invoice_id = params[:invoice_id]

    case group
      when 1,2,3,4,5,6,7,8
        url = uri(group) + 'invoice_rejected/'
        request_params = {
          invoice_id: invoice_id
        }
        return response = HTTParty.post(url, :body => request_params.to_json , headers: headers(group))
    end
  end



  # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

  def self.uri(group)
    case group
      when 3, 8
        'http://integra' + group.to_s + '.ing.puc.cl/b2b/'
      when 7
        'http://integra' + group.to_s + '.ing.puc.cl/api/'
      end
  end

  def self.headers(group)
    case group
    when 1,2,3,4,5,6,7,8
      response = { 
        'Content-Type' => 'application/json', 
        'Accept' => 'application/json',
        'Authorization' => 'Token ' + get_token(group: group).to_s
      }
    end

    return response
  end

  def self.username(group)
    case group
      when 3
        'grupo3'
    end
  end

  def self.password(group)
    case group
      when 3
        'grupo3grupo3'
    end
  end

end