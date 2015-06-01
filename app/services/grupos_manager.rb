class GruposManager

  def get_token(params)
    group = params[:group]

    case group
      when 3
        url = uri(3) + 'get_token'
        request_params = {
          username: username(group),
          password: password(group)
        }
        return response = HTTParty.post(url, :body => request_params.to_json , :headers =>{ 'Content-Type' => 'application/json'})
      when 4
        # ...
    end
  end

  # params = { group: , order_id: }
  def new_order(params)
    group = params[:group]
    order_id = params[:order_id]

    case group
      when 3
        url = uri(3) + 'new_order'
        request_params = {
          order_id: order_id
        }
        return response = HTTParty.post(url, :body => request_params.to_json , headers: headers(group))
      when 4
        # ...
    end
  end

  # params = { group: 3, order_id: "123j234oiu" }
  def order_accepted(params)
    group = params[:group]
    order_id = params[:order_id]

    case group
      when 3
        url = uri(3) + 'order_accepted'
        request_params = {
          order_id: order_id
        }
        return response = HTTParty.post(url, :body => request_params.to_json , headers: headers(group))
      when 4
        # ...
    end
  end

  # params = { group: 3, order_id: "123j234oiu" }
  def order_canceled(params)
    group = params[:group]
    order_id = params[:order_id]

    case group
      when 3
        url = uri(3) + 'order_canceled'
        request_params = {
          order_id: order_id
        }
        return response = HTTParty.post(url, :body => request_params.to_json , headers: headers(group))
      when 4
        # ...
    end
  end

  # params = { group: 3, order_id: "123j234oiu" }
  def order_rejected(params)
    group = params[:group]
    order_id = params[:order_id]

    case group
      when 3
        url = uri(3) + 'order_rejected'
        request_params = {
          order_id: order_id
        }
        return response = HTTParty.post(url, :body => request_params.to_json , headers: headers(group))
      when 4
        # ...
    end
  end

  # params = { group: 3, invoice_id: "123j234oiu" }
  def invoice_created(params)
    group = params[:group]
    invoice_id = params[:invoice_id]

    case group
      when 3
        url = uri(3) + 'invoice_created'
        request_params = {
          invoice_id: invoice_id
        }
        return response = HTTParty.post(url, :body => request_params.to_json , headers: headers(group))
      when 4
        # ...
    end
  end

  # params = { group: 3, invoice_id: "123j234oiu" }
  def invoice_paid(params)
    group = params[:group]
    invoice_id = params[:invoice_id]

    case group
      when 3
        url = uri(3) + 'invoice_paid'
        request_params = {
          invoice_id: invoice_id
        }
        return response = HTTParty.post(url, :body => request_params.to_json , headers: headers(group))
      when 4
        # ...
    end
  end

  # params = { group: 3, invoice_id: "123j234oiu" }
  def invoice_rejected(params)
    group = params[:group]
    invoice_id = params[:invoice_id]

    case group
      when 3
        url = uri(3) + 'invoice_rejected'
        request_params = {
          invoice_id: invoice_id
        }
        return response = HTTParty.post(url, :body => request_params.to_json , headers: headers(group))
      when 4
        # ...
    end
  end



  # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 

  def uri(group)
    case group
      when 3
        'http://integra3.ing.puc.cl/b2b/'
      end
    
  end

  def headers(group)
    case group
      when 3
        response = {
          'Content-Type': 'application/json',
          'token': get_token(group: group)
        }
      end
  end

  def username(group)
    # credencial
  end

  def password(group)
    # credencial
  end

end