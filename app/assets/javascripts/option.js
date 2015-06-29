var ready = function() {

	$(".option").click(function(){

		var id = $(this).attr("id");
		console.log(id);

		var f_content_id = '#option_content_' + id.split('_')[1];
		console.log(f_content_id);

		// // removemos la clase active de las demas options
		$('.option').removeClass('active');
		// dejamos como active a la option clickeada
		$(this).addClass('active');
		// escondeos todos los contents
		$('.option_content').hide();
		// mostramos el que corresponde con la option clickeada
		$(f_content_id).fadeIn();
	});
};

$(document).ready(ready);
$(document).on('page:load', ready);