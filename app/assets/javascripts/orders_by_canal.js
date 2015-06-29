var ready = function() {

	if ($('#orders_by_canal_chart').size() > 0)
	{
		$.ajax({
            url: '/dashboards/skus_by_canal/',
            dataType: 'json',
            success: function(data){
            	var ftp_serie = data[0];
            	var e_commerce_serie = data[1];
            	var b2b_serie = data[2];

            	$('#orders_by_canal_chart').highcharts({

			        chart: {
			            type: 'column'
			        },

			        title: {
			            text: 'Nivel de consumo de SKUs según canal'
			        },

			        xAxis: {
			            categories: [	"Yogur (5)", "Sal (26)", 
			            				"Levadura (27)", 
			            				"Tela de lino (28)", 
			            				"Tela de lana (29)", 
			            				"Tela de algodón (30)", 
			            				"Agave (44)"],
			            title: {
			                text: 'Pedidos (sku)'
			            }
			        },

			        yAxis: {
			            allowDecimals: false,
			            min: 0,
			            title: {
			                text: 'Numero de pedidos'
			            }
			        },

			        tooltip: {
			            formatter: function () {
			                return '<b>' + this.x + '</b><br/>' +
			                    this.series.name + ': ' + this.y + '<br/>' +
			                    'Total: ' + this.point.stackTotal;
			            }
			        },

			        plotOptions: {
			            column: {
			                stacking: 'normal'
			            }
			        },

			        series: [ftp_serie, e_commerce_serie, b2b_serie]
			    });

            }

        });
	}
};

$(document).ready(ready);
$(document).on('page:load', ready);