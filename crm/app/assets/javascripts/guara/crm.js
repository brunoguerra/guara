jQuery(function() {
  $('form').on('click', '.remove_fields', function(event) {
    $(this).prev('input[type=hidden]').val('1');
    $(this).closest('fieldset').hide();
    return event.preventDefault();
  });

  $('form, div.list_nested_form').on('click', '.add_fields', function(event) {
    var regexp, time;
    time = new Date().getTime();
    regexp = new RegExp($(this).data('id'), 'g');
    $(this).before($(this).data('fields').replace(regexp, time));
    return event.preventDefault();
  });

  $('input.readonly').on('keydown', function(e){
    return false;
  });

  $(document).on('ready', function(event) {
    return $("select.multiselect").each(function(i) {
      var inp, select, url_json, placeholder;
      if ($(this).attr("data-placeholder") != null) {
        placeholder = $(this).attr("data-placeholder");
      }

      if ($(this).attr("data-json-url") != null) {
        url_json = $(this).attr("data-json-url");
        inp = $("<input>").attr("id", $(this).name).attr('data-ajax', 1).attr("class", $(this).attr("class")).val($(this).val());
        select = $(this);
        $($(this).parent()).append(inp);
        $(inp).select2({
          maximumInputLength: 10,
          placeholder: placeholder,
          ajax: {
            data: function(term, page) {
              return {
                search: term,
                page_limit: 10
              };
            },
            dataType: 'json',
            results: function(data, term) {
              return {
                results: data
              };
            },
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
            var opt;
            opt = $(select.children()[0]);
            if ((!opt) || (opt.attr('id') !== data.id)) {
              opt.remove();
              select.append($('<option></option>').attr('value', data.id).text(data.name));
            }
            select.val(data.id);
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
          maximumInputLength: 10,
          placeholder: placeholder,
        });
      }
    });
  });
});