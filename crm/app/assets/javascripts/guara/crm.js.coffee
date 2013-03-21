jQuery ->
  $('form').on 'click', '.remove_fields', (event) ->
    $(this).prev('input[type=hidden]').val('1')
    $(this).closest('fieldset').hide()
    event.preventDefault()

  $('form').on 'click', '.add_fields', (event) ->
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $(this).before($(this).data('fields').replace(regexp, time))
    event.preventDefault()

  $(document).on 'ready', (event) ->
    $("select.multiselect").each (i) ->
      if $(this).attr("data-json-url")?
        url_json = $(this).attr("data-json-url")
        inp = $("<input>").attr("name", $(this).name ).attr("class", $(this).attr("class"))
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
          formatResult: (data) ->
            return data.name 
          formatSelection: (data) ->
            return data.name
          dropdownCssClass: "bigdrop"
          escapeMarkup: (m) -> 
            return m  
        $(this).remove()
      else
        $(this).select2 maximumInputLength: 10
		
	

