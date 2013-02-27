

$(function() {
	$("#form_ajax_name_submit").on("click", function() {
		form = $("#form_ajax_name");
		
		$.ajax({
			url: form.attr("action"),
			data: $("#form_ajax_name :input"),
			type: "POST",
		}).complete(function(data, status) {
			console.log(data);
			ajax_form_funcion_callback(data, status);
		})
	})
})