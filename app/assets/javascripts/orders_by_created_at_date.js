var orders_by_deliver_date_function = function() {

	if ($('#orders_by_created_at_date').size() > 0)
	{
		var ftp_data;
		var e_commerce_data = [];
		var b2b_data = [];
		$.ajax({
            url: '/dashboards/orders_by_created_at_date?canal=ftp',
            dataType: 'json',
            success: function(data){
            	ftp_data = data;
            }

        });

		$.ajax({
            url: '/dashboards/orders_by_created_at_date?canal=b2c',
            dataType: 'json',
            success: function(data){
            	e_commerce_data = data;
            }

        });

		$.ajax({
            url: '/dashboards/orders_by_created_at_date?canal=b2b',
            dataType: 'json',
            success: function(data){
            	b2b_data = data;

            	$('#orders_by_created_at_date').highcharts({
	                chart:{
	                    zoomType: 'x',
	                },
	                title: {
	                    text: 'Pedidos recibidos',
	                    x: -20 //center
	                },
	                xAxis: {
	                    type: 'datetime',
	                    ordinal: false
	                },
	                yAxis: {
	                    title: {
	                        text: 'Pedidos recibidos en el tiempo'
	                    }
	                },
	                tooltip: {
	                    valueSuffix: ' pedidos'
	                },
	                legend: {
	                    layout: 'vertical',
	                    align: 'right',
	                    verticalAlign: 'middle',
	                    borderWidth: 0
	                },
	                series: 
	                [
	                    {
	                        name: 'ftp',
	                        data: ftp_data
	                    },
	                    {
	                        name: 'b2c',
	                        data: e_commerce_data
	                    },
	                    {
	                        name: 'b2b',
	                        data: b2b_data
	                    }
	                ]
	            });





            }

        });

	}
};

$(document).ready(orders_by_deliver_date_function);
$(document).on('page:load', orders_by_deliver_date_function);