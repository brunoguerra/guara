
select2Results =
  select2ResultFormatResult: (select2Result) ->
    markup = "<table class='select2Result-result'><tr>"
    markup += "<td class='select2Result-info'><div class='select2Result-title'>" + select2Result.description + "</div>"
    markup += "</td></tr></table>"
    markup

  select2ResultFormatSelection: (select2Result) ->
    select2Result.description


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
        inp = $("<input type='hidden'>").attr("id", $(this).id + "_input").attr("class", $(this).attr("class"))
        $($(this).parent()).append inp
        $(inp).select2
          maximumInputLength: 10
          ajax:
            data: (term, page) ->
              search: term # search term
              page_limit: 10
            dataType: 'jsonp'
            results: (data, page) ->
              console.log(data)
              results: data.results
            url: url_json
          formatResult: select2Results.select2ResultFormatResult
          formatSelection: select2Results.select2ResultFormatSelection
        $(this).remove()
      else
        $(this).select2 maximumInputLength: 10
	

