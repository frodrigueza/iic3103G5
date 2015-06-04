class ApiManager
	# Este servicio maneja el comportamiento de los métodos que son llamados a nuestro controlador b2b



	# ODERS # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
    def self.order_canceled(params)
    	if HttpManager.exist_order(params[:order_id])
	        response = {
	            status: 200,
	            content:{
	                orden_cancelada: HttpManager.get_oc(id_oc: params[:order_id])
	            }
	        }
	    else
	    	response = {
	    		status: 400,
	    		content: {
	    			respuesta: "No existe tal orden de compra"
	    		}
	    	}
    	end

    	return response
    end

    def self.order_accepted(params)
    	if HttpManager.exist_order(params[:order_id])
	        response = {
	            status: 200,
	            content:{
	            	respuesta: "Muchas gracias",
	                orden_aceptada: HttpManager.get_oc(id_oc: params[:order_id])
	            }
	        }
	    else
	    	response = {
	    		status: 400,
	    		content: {
	    			respuesta: "No existe tal orden de compra"
	    		}
	    	}
    	end

    	return response
    end

    def self.order_rejected(params)
    	if HttpManager.exist_order(params[:order_id])
	        response = {
	            status: 200,
	            content:{
	            	respuesta: "Muchas gracias",
	                orden_rechazada: HttpManager.get_oc(id_oc: params[:order_id])
	            }
	        }
	    
	    	response = {
	    		status: 400,
	    		content: {
	    			respuesta: "No existe tal orden de compra"
	    		}
	    	}
    	end

    	return response
    end

    # INVOICES # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
    def self.invoice_created(params)
    	if HttpManager.exist_invoice(params)

    		bool_factura_recibida = HttpManager.recibir_factura(invoice_id: params[:invoice_id])

    		if bool_factura_recibida != 'Esta siendo procesada'
    			response = {
		            status: 200,
		            content:{
		            	respuesta: bool_factura_recibida,
		                factura_creada: HttpManager.obtener_factura(invoice_id: params[:invoice_id])
		            }
	        	}
	        elsif 
	        	response = {
		            status: 200,
		            content:{
		            	respuesta: "Muchas gracias su factura esta pendiente por pagar ",
		                factura_creada: HttpManager.obtener_factura(invoice_id: params[:invoice_id])
		            }
	        	}

    		end

	        
	    else
	    	response = {
	    		status: 400,
	    		content: {
	    			respuesta: "No existe tal factura"
	    		}
	    	}
    	end

    	return response
    end

    def self.invoice_paid(params)

    	factura_pagada = FacturaManager.revisar_factura_pagada(params[:invoice_id])

    	if HttpManager.exist_invoice(params[:invoice_id]) && factura_pagada[:estado] == 'pagada'
	        response = {
	            status: 200,
	            content:{
	            	respuesta: "Muchas gracias por pagar",
	                factura_pagada: HttpManager.obtener_factura(params[:invoice_id])
	            }
	        }
	    elsif HttpManager.exist_invoice(params[:invoice_id]) && factura_pagada[:estado] != 'pagada'
	    	response = {
	    		status: 200,
	    		content: {
	    			respuesta: "No se ha verificado el estado pagado"
	    		}
	    	}
	    else
	    	response = {
	    		status: 200,
	    		content: {
	    			respuesta: "No existe tal factura"
	    		}
	    	}
    	end

    	return response
    end

    def self.invoice_rejected(params)

    	resp_factura_rechazada = FacturaManager.factura_fue_rechazada(params[:invoice_id])

    	if HttpManager.exist_invoice(params[:invoice_id])
	        response = {
	            status: 200,
	            content:{
	            	respuesta: "Muchas gracias por avisar",
	                factura_rechazada: HttpManager.obtener_factura(params[:invoice_id])
	            }
	        }
	    else
	    	response = {
	    		status: 400,
	    		content: {
	    			respuesta: "No existe tal factura"
	    		}
	    	}
    	end

    	return response
    end

end