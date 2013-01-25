// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require bootstrap
//= #require bootstrap-datepicker
//= #require bootstrap-datepicker/locales/bootstrap-datepicker.pt
//= require guara/jquery-ui-timepicker-addon
//= require_tree .

$(document).on("focus", "[data-behaviour~='datepicker']", function(e){
    $(this).datepicker({"format": "dd/mm/yyyy hh:mm", "weekStart": 1, "autoclose": true});
});

$(document).on("focus", "[data-behaviour~='datetimepicker']", function(e){
    $(this).datetimepicker({ dateFormat: "dd/mm/yy", timeFormat: "hh:mm", "weekStart": 1, "autoclose": true, 
	hourGrid: 4, minuteGrid: 10, minDateTime: new Date()});
});

$(document).ready(function(){

  $('.remote_form')
    .bind("ajax:beforeSend", function(evt, xhr, settings){
      var $submitButton = $(this).find('input[name="commit"]');

      // Update the text of the submit button to let the user know stuff is happening.
      // But first, store the original text of the submit button, so it can be restored when the request is finished.
      $submitButton.data( 'origText', $(this).text() );
      $submitButton.text( "Submitting..." );

    })
    .bind("ajax:success", function(evt, data, status, xhr){
      var $form = $(this);

      // Reset fields and any validation errors, so form can be used again, but leave hidden_field values intact.
      $form.find('textarea,input[type="text"],input[type="file"]').val("");
      $form.find('div.validation-error').empty();

      // Insert response partial into page below the form.
      $('#comments').append(xhr.responseText);

    })
    .bind('ajax:complete', function(evt, xhr, status){
      var $submitButton = $(this).find('input[name="commit"]');

      // Restore the original submit button text
      $submitButton.text( $(this).data('origText') );
    })
    .bind("ajax:error", function(evt, xhr, status, error){
      var $form = $(this),
          errors,
          errorText;

      try {
        // Populate errorText with the comment errors
        errors = $.parseJSON(xhr.responseText);
      } catch(err) {
        // If the responseText is not valid JSON (like if a 500 exception was thrown), populate errors with a generic error message.
        errors = {message: "Por favor, ocorreu um erro ao tratar a resposta do servidor, tente mais tarde."};
      }

      // Build an unordered list from the list of errors
      errorText = "<div class=\"alert alert-block alert-error\"><h4>Erros ao registrar dados:</h4> \n<ul>";

      for ( error in errors ) {
        errorText += "<li>" + error + ': ' + errors[error] + "</li> ";
      }

      errorText += "</ul></div>";

	  $(document).scrollTop();

      // Insert error list into form
      $form.find('div.validation-error').html(errorText);
    });

});

function showMessage(message_content) {
	$(".alert-ajax").show().html(message_content);
	$(document).scrollTop();
}

$(function() {
	$( "#accordion" ).accordion();
});