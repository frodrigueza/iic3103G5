class ApiManager
	# Este servicio maneja el comportamiento de los métodos que son llamados a nuestro controlador b2b



	# ODERS # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
    def self.order_cancelled(params)
    	if HttpManager.exist_order(params[:order_id])
	        response = {
	            status: 200,
	            content:{
	                orden_cancelada: HttpManager.get_oc(params[:order_id])
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
	                orden_aceptada: HttpManager.get_oc(params[:order_id])
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
	                orden_rechazada: HttpManager.get_oc(params[:order_id])
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

    # INVOICES # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # 
    def self.invoice_created(params)
    	if HttpManager.exist_invoice(params[:invoice_id])
	        response = {
	            status: 200,
	            content:{
	            	respuesta: "Muchas gracias",
	                factura_creada: HttpManager.obtener_factura(params[:invoice_id])
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

    def self.invoice_paid(params)
    	if HttpManager.exist_invoice(params[:invoice_id])
	        response = {
	            status: 200,
	            content:{
	            	respuesta: "Muchas gracias",
	                factura_pagada: HttpManager.obtener_factura(params[:invoice_id])
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

    def self.invoice_rejected(params)
    	if HttpManager.exist_invoice(params[:invoice_id])
	        response = {
	            status: 200,
	            content:{
	            	respuesta: "Muchas gracias",
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