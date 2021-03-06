var ready = function() {

	if ($('#orders_by_sku_group_by_canal').size() > 0)
	{
		$.ajax({
            url: '/dashboards/orders_by_sku_group_by_canal/',
            dataType: 'json',
            success: function(data){
            	var ftp_serie = data[0];
            	var e_commerce_serie = data[1];
            	var b2b_serie = data[2];

            	$('#orders_by_sku_group_by_canal').highcharts({

			        chart: {
			            type: 'column'
			        },

			        title: {
			            text: 'Pedidos según SKU'
			        },

			        xAxis: {
			            categories: [	"Yogur (5)", "Sal (26)", 
			            				"Levadura (27)", 
			            				"Tela de lino (28)", 
			            				"Tela de lana (29)", 
			            				"Tela de algodón (30)", 
			            				"Agave (44)"],
			            title: {
			                text: 'Productos (sku)'
			            }
			        },

			        yAxis: {
			            allowDecimals: false,
			            min: 0,
			            title: {
			                text: 'Numero de pedidos'
			            },
			            stackLabels: {
			                enabled: true,
			                style: {
			                    color: (Highcharts.theme && Highcharts.theme.textColor) || 'gray'
			                }
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
			                stacking: 'normal',
			                dataLabels: {
			                    enabled: false,
			                    color: (Highcharts.theme && Highcharts.theme.dataLabelsColor) || 'white',
			                    style: {
			                        textShadow: '0 0 0px black'
			                    }
			                }
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