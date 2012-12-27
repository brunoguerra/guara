

//Modal window
//---------------------------------------------------------------------------------------
$(function() {
	$(".tasks.side .new-link").click(function(e) {	
		$(".tasks.side .new .form").modal({
	      "backdrop"  : "static",
	      "keyboard"  : true,
	      "show"      : true,    // this parameter ensures the modal is shown immediately
		  "scrollbars": true
	    });
	});
	
    // wire up the buttons to dismiss the modal when shown
    $(".tasks.side .new .form").bind("show", function() {
        $(".tasks.side .new .form #close").click(function(e) {
            // do something based on which button was clicked
            // we just log the contents of the link element for demo purposes
            //console.log("button pressed: "+$(this).html());
            // hide the dialog box
            $(".tasks.side .new .form").modal('hide');
        });
    });

    // remove the event listeners when the dialog is hidden
    $(".tasks.side .new .form").bind("hide", function() {
        // remove event listeners on the buttons
        $(".tasks.side .new .form #close").unbind();
    });

    
});


//ajax complex load
$.ajax({
	url: "<%= customer_tasks_path(@customer) %>.json",
	context: document.body,
	dataType: "json",
	complete: function(xhr) {
		try {
	        resp = $.parseJSON(xhr.responseText);
			alert(resp.html)
	      } catch(err) {
	        resp = {html: "Por favor, ocorreu um erro ao tratar a resposta do servidor, tente mais tarde."};
	      }
		alert("<h1>TESTE</h1>"+resp.html+" ");
		$(".tasks.side .new .tasks-list").html("<h1>TESTE</h1>"+resp.html+" ");
	}
});
