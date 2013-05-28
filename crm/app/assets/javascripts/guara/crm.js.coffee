jQuery ->
  $('form').on 'click', '.remove_fields', (event) ->
    $(this).prev('input[type=hidden]').val('1')
    $(this).closest('fieldset').hide()
    event.preventDefault()

  $('form, div.list_nested_form').on 'click', '.add_fields', (event) ->
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $(this).before($(this).data('fields').replace(regexp, time))
    event.preventDefault()

  $(document).on 'ready', (event) ->
    $("select.multiselect").each (i) ->
      if $(this).attr("data-json-url")?
        url_json = $(this).attr("data-json-url")
        inp = $("<input>").attr("id", $(this).name ).attr('data-ajax', 1).attr("class", $(this).attr("class")).val($(this).val())
        select = $(this)

        $($(this).parent()).append inp
        $(inp).select2
          maximumInputLength: 10
          ajax:
            data: (term, page) ->
              search: term # search term
              page_limit: 10
            dataType: 'json'
            results: (data, term) ->
              results: data
            url: url_json
          initSelection: (element, callback) ->
            id=$(element).val()
            if (id isnt "")
              data = 
                id: $(select.children()[0]).attr('value')
                name: $(select.children()[0]).text()
              callback(data)
          formatResult: (data) ->
            return data.name 
          formatSelection: (data) ->
            opt = $(select.children()[0])
            if (not opt) or (opt.attr('id') isnt data.id)
              opt.remove()
              select.append($('<option></option>').attr('value', data.id).text(data.name))
            select.val(data.id)
            return data.name

          dropdownCssClass: "bigdrop"
          escapeMarkup: (m) -> 
            return m  
        $(this).hide()
      else
        $(this).select2 maximumInputLength: 10
		
	

