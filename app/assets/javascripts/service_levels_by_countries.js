var ready = function() {

	if ($('#service_levels_by_countries').size() > 0)
	{
		$.ajax({
            url: '/dashboards/service_levels_by_countries/',
            dataType: 'json',
            success: function(data){
            	var countries = data[0];
            	var received = data[1];
            	var delivered = data[2];

            	console.log(countries);
            	console.log(received);
            	console.log(delivered);

            	$('#service_levels_by_countries').highcharts({

			        chart: {
			            type: 'column'
			        },

			        title: {
			            text: 'Nivel de servicio por País'
			        },

			        xAxis: {
			            categories: countries,
			            title: {
			                text: 'Paises'
			            }
			        },

			        yAxis: {
			            allowDecimals: false,
			            min: 0,
			            title: {
			                text: 'Nivel de servicio'
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
			                stacking: 'percent',
			                dataLabels: {
			                    enabled: false,
			                    color: (Highcharts.theme && Highcharts.theme.dataLabelsColor) || 'white',
			                    style: {
			                        textShadow: '0 0 0px black'
			                    }
			                }
			            }
			        },

			        series: [received, delivered]
			    });

            }

        });
	}
};

$(document).ready(ready);
$(document).on('page:load', ready);