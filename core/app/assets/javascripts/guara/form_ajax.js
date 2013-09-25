
var ajax_form_commons_functions = {
  /**
   * parse error and show bootstrap error alert
   * needs a div.validation-error to display error
   */
  error: function(evt, xhr, status, error){
    var $form = $(this),
        errors,
        errorText;
    evt.stopPropagation();
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
  },

  applyBinds: function(selector) {
    $(selector)
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
    .bind("ajax:error", ajax_form_commons_functions.error);
  }
};


$(document).ready(function(){
  ajax_form_commons_functions.applyBinds('.remote_form');
});

/** search ajax **/

var formSearchAjax = (function($){
    return function(form, assgin_val_to, param_options) {
      var me = null,
          $form = $(form),
          default_params = (param_options["default_params"] || {})
          interval= null,
          service_url = param_options["url"],
          options = ( param_options || {} ),
          last_result = [];

      me = {
        params: {},
        url: null,
        callbacks: [],

        change_param: function(property, value) {
          me.params[property] = value;
          me.wait_idle_query();
        },

        set_params: function(params) {
          me.params = params;
          me.wait_idle_query();
        },        

        params: function() {
          return me.params;
        },

        wait_idle_query: function() {
          clearTimeout(me.interval);
          me.interval = setTimeout(function() {
            me.peform_query();
          }, 1000);
        },

        peform_query: function() {
          $.ajax({
            url: me.url,
            statusCode: {
              404: function() {
                displayMessage("page not found", "form-ajax-search-orders", "error");
              },
              500: function() {
                displayMessage("System fault on parse remote data", "form-ajax-search-orders", "error");
              }
            },
            data: me.params,
            type: (me.params["http_method"] || "GET"),
          }).done(function(data) {
            me.search_result(data);
          })
        },

        search_result: function (data, status) {
          var content;
          me.last_result = data;
          if (isFunction(options["formatResults"])) {
            content = options["formatResults"](data, status);
          } else {
            content = me.defaultFormatResults(data);
          }
          $('#results', $form).html(content);

          return content;
        },

        defaultFormatResults: function(data) {
          //@TODO
        },

        show: function () {
          $form.removeClass('hide');
          $('.first', $form).focus();
        },

        close: function () {
          $form.addClass('hide');
        },

        init: function() {
          $('.close', $form).on('click', function() { 
            me.close();
          });
          $form.formSearchAjax = me;
        }, 

        /**
         * callbacks
         */
        on: function(callback, function_refer) {
          this.callbacks[callback] = function_refer;
        },

        isCallback: function(name_function) {
          return typeof this.callbacks[name_function] == "function";
        },

        callback: function() {
          var shift = [].shift,
              name_function = shift.apply(arguments); //in case you need it


          return ((!this.isCallback(name_function)) || (this.callbacks[name_function].apply(this, arguments)));
        },

        selected_index: function(index) {
          if (isFunction(options["onSelectedItem"])) {
            if (!options["onSelectedItem"](me.last_result[index], index, $form, me)) return;
          }

          if (isFunction(options["selectedValue"])) {
            if (!options["selectedValue"](me.last_result[index], index, $form, me)) return;
          } else {
            $(assgin_val_to).val(me.last_result[index]);
          }
          me.close();
        },

      };


      for (var d in default_params) { me.params[d] = default_params[d]; };
      me.url = service_url;
      me.init();

      return me;
    }
  })(jQuery);
