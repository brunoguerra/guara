jQuery(function() {
  $('form').on('click', '.remove_fields', function(event) {
    $(this).prev('input[type=hidden]').val('1');
    $(this).closest('fieldset').hide();
    return event.preventDefault();
  });

  $('form, div.list_nested_form').on('click', '.add_fields', function(event) {
    var time = new Date().getTime(),
        regexp = new RegExp($(this).data('id'), 'g');    
    
    $(this).before($(this).data('fields').replace(regexp, time));
    return event.preventDefault();
  });

  $('input.readonly').on('keydown', function(e){
    var k = (e.which) ? e.which : e.keyCode;
    if ([9,13].indexOf(k) == -1) return false;
  });

  
  $("select.multiselect").each(function(i) {
    var inp, 
        select, 
        url_json,
        placeholder,
        minimumInputLength = 3;

    if ($(this).attr("data-placeholder") != null) {
      placeholder = $(this).attr("data-placeholder");
    }

    if ($(this).attr("data-minimumInputLength") != null) {
      minimumInputLength = $(this).attr("data-minimumInputLength");
    }

    if ($(this).attr("data-json-url") != null) {
      url_json = $(this).attr("data-json-url");
      inp = $("<input>").attr("id", $(this).name+'-input-ajax').attr('data-ajax', 1).attr("class", $(this).attr("class")).val($(this).val());
      select = $(this);
      $($(this).parent()).append(inp);
      $(inp).select2({
        maximumInputLength: 20,
        allowClear: true,
        minimumInputLength: minimumInputLength,
        placeholder: placeholder,
        ajax: {
          data: function(term, page) {
            return {
              search: term,
              page_limit: 10
            };
          },
          dataType: 'json',
          url: url_json
        },
        initSelection: function(element, callback) {
          var data, id;
          id = $(element).val();
          if (id !== "") {
            data = {
              id: $(select.children()[0]).attr('value'),
              name: $(select.children()[0]).text()
            };
            return callback(data);
          }
        },
        formatResult: function(data) {
          return data.name;
        },
        formatSelection: function(data) {
          var opt,
              event;

          opt = $(select.children()[0]);

          if ((!opt) || (opt.attr('id') !== data.id)) {
            opt.remove();
            select.append($('<option></option>').attr('value', data.id).text(data.name));
          }
          select.val(data.id);
          
          /*event*/
          event = jQuery.Event("change", { val: data.id });
          select.trigger(event);

          return data.name;
        },
        dropdownCssClass: "bigdrop",
        escapeMarkup: function(m) {
          return m;
        }
      });
      return $(this).hide();
    } else {
      return $(this).select2({
        maximumInputLength: 20,
        allowClear: true,
        placeholder: placeholder,
      });
    }
  });
});