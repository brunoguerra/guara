/*
 * DataTables
 */
function applyDataTable(selector) {
  $(selector).dataTable({
    "sDom": "<'row-fluid'<'span6'T><'span6'f>r>t<'row-fluid'<'span6'i><'span6'p>>",


    "oTableTools": {
      "sSwfPath": "/assets/jquery.dataTables.dataTools/copy_csv_xls_pdf.swf",
      "aButtons": [
        "copy",
        "print",
        {
          "sExtends":    "collection",
          "sButtonText": 'Save <span class="caret" />',
          "aButtons":    [ "xls" ],
        }
      ]
    },

    "oLanguage": {
      "sUrl": "/assets/jquery.dataTables.pt-BR.json"
    },

    "sPaginationType": "bootstrap"

  });
}


function applyMultiSelect(selector) {
    $(selector).each(function(i) {
    var inp, 
        select, 
        url_json,
        placeholder="SELECT",
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
          dataType: 'json',
          url: url_json,
          quietMillis: 500,

          data: function(term, page) {
            return {
              search: term,
              page_limit: 10
            };
          },
          
          results: function(data, term) {
            return {
              results: data
            };
          },
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
}



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

  $(document).bind("ajaxSend", function(){
    $("#loader").show();
    $("body").removeClass('ajaxCompleted')
  }).bind("ajaxComplete", function(){
    $("#loader").hide();
    $("body").addClass('ajaxCompleted')
  });

  
  applyMultiSelect('select.multiselect');

  applyDataTable('.dataTable');

  $('[data-toggle]').tooltip({})

});


function dataTablesAppend(table_selector, row) {
  var $tr,
      table = $(table_selector).dataTable(),
      addId;

  //add new deal
  addId = table.fnAddData(row);
  $tr = $(table.fnSettings().aoData[addId[0]].nTr);

  return $tr;
}

function dataTablesRemove(table_selector, selector) {
  var table = $(table_selector).dataTable();
  $(selector).each(function(){ 
    table.fnDeleteRow(table.fnGetPosition(this));
  });
}