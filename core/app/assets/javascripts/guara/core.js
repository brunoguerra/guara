//= require jquery
//= require jquery-ui
//= require jquery.popover
//= require jquery_ujs
//= require bootstrap
//= require guara/utils
//= require guara/jquery-ui-timepicker-addon
//= require guara/jquery-ui-timepicker-addon
//= require guara/jquery.mask
//= require guara/jquery.price_format.min.js
//= require guara/jquery-numeric.js
//= require guara/fcbk.js
//= require select2/select2
//= require active_admin
//= #require i18n
//= #require i18n/translations
//= require guara/core/pt-BR
//= require hogan.js

$(document).on("focus", "[data-behaviour~='datepicker']", function(e){
    $(this).datepicker({"format": "dd/mm/yyyy hh:mm", "weekStart": 1, "autoclose": true});
});

$(document).on("focus", "[data-behaviour~='datetimepicker']", function(e){
    $(this).datetimepicker({ dateFormat: "dd/mm/yy", timeFormat: "hh:mm", "weekStart": 1, "autoclose": true, 
	hourGrid: 4, minuteGrid: 10});
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

function displayMessage(msg, id, time, type) {
  if (time==null) time = 8000; 
  if (type==null) type = "error"; 
  if ($('#'+id).size()==0) {
      var div = $('<div class="alert alert-'+type+' hide" id="'+id+'">'+msg+'</div>');
      $('section.container').prepend(div);
      div.fadeIn().delay(time).fadeOut();
      setTimeout(function(){ div.remove(); }, time+500);
    }
}

function showMessage(message_content) {
	displayMessage(message_content, "showMessage", "warning");
	$(document).scrollTop();
}

$(function() {
	$( "#accordion" ).accordion();
});


jQuery.fn.center = function () {
    this.css("position","absolute");
    this.css("top", Math.max(0, ((jQuery(window).height() - jQuery(this).outerHeight()) / 2) + 
                                                jQuery(window).scrollTop()) + "px");
    this.css("left", Math.max(0, ((jQuery(window).width() - jQuery(this).outerWidth()) / 2) + 
                                                jQuery(window).scrollLeft()) + "px");
    return this;
}