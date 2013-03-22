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
        inp = $("<input>").attr("id", $(this).name ).attr("class", $(this).attr("class"))
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
          formatResult: (data) ->
            return data.name 
          formatSelection: (data) ->
            select.append($('<option></option>').attr('value', data.id).text(data.name))
            select.val(data.id)
            return data.name
          dropdownCssClass: "bigdrop"
          escapeMarkup: (m) -> 
            return m  
        $(this).hide()
      else
        $(this).select2 maximumInputLength: 10
		
	

