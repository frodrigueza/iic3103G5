var orders_by_deliver_date_function = function() {

	if ($('#orders_by_deliver_date').size() > 0)
	{
		var ftp_data;
		var e_commerce_data = [];
		var b2b_data = [];
		$.ajax({
            url: '/dashboards/orders_by_deliver_date?canal=ftp',
            dataType: 'json',
            success: function(data){
            	ftp_data = data;
            	console.log('ftp');
            }

        });

		$.ajax({
            url: '/dashboards/orders_by_deliver_date?canal=e_commerce',
            dataType: 'json',
            success: function(data){
            	e_commerce_data = data;
            	console.log('e-commerce');
            }

        });

		$.ajax({
            url: '/dashboards/orders_by_deliver_date?canal=b2b',
            dataType: 'json',
            success: function(data){
            	b2b_data = data;

            	$('#orders_by_deliver_date').highcharts({
	                chart:{
	                    zoomType: 'x',
	                },
	                title: {
	                    text: 'Entregas diarias de pedidos',
	                    x: -20 //center
	                },
	                xAxis: {
	                    type: 'datetime',
	                    ordinal: false
	                },
	                yAxis: {
	                    title: {
	                        text: 'Numero de entregas'
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
	                    }
	                ]
	            });





            }

        });

	}
};

$(document).ready(orders_by_deliver_date_function);
$(document).on('page:load', orders_by_deliver_date_function);