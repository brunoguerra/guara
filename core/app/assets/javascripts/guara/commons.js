

/*
 * DataTables
 */
function applyDataTable(selector, options) {

  params = {
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

  }
  params = jQuery.extend(params, options);
  if (typeof $(selector).dataTable == 'function') {
    $(selector).dataTable(params);
  }
}

if (typeof jQuery.fn.dataTableExt == 'function') {
jQuery.extend( jQuery.fn.dataTableExt.oSort, {
    "date-euro-pre": function ( a ) {
        if ($.trim(a) != '') {
            var frDatea = $.trim(a).split(' ');
            var frTimea = frDatea[1].split(':');
            var frDatea2 = frDatea[0].split('/');
            var x = (frDatea2[2] + frDatea2[1] + frDatea2[0] + frTimea[0] + frTimea[1] + frTimea[2]) * 1;
        } else {
            var x = 10000000000000; // = l'an 1000 ...
        }
         
        return x;
    },
 
    "date-euro-asc": function ( a, b ) {
        return a - b;
    },
 
    "date-euro-desc": function ( a, b ) {
        return b - a;
    }
} );
}

function applyMultiSelect(selector) {
    $(selector).each(function(i) {
    var inp,
        input_name = "undef", 
        select, 
        url_json,
        placeholder="SELECT",
        multiselect_ajax=false,
        minimumInputLength = 3;

    if ($(this).attr("data-placeholder") != null) {
      placeholder = $(this).attr("data-placeholder");
    }

    if ($(this).attr("data-multiple") != null) {
      multiselect_ajax = $(this).attr("data-multiple").toLowerCase()=="true";
    }

    if ($(this).attr("data-minimumInputLength") != null) {
      minimumInputLength = $(this).attr("data-minimumInputLength");
    }

    if ($(this).attr("data-json-url") != null) {
      url_json = $(this).attr("data-json-url");
      input_name = $(this).attr("name") || $(this).attr("id");
      inp = $("<input>").attr("id", input_name+'-input-ajax').attr('data-ajax', 1).attr("class", $(this).attr("class")).val($(this).val());
      select = $(this);
      /* append auxiliar */
      $($(this).parent()).append(inp);
      /* select2 init */
      $(inp).select2({
        maximumInputLength: 20,
        allowClear: true,
        minimumInputLength: minimumInputLength,
        multiple: multiselect_ajax,
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
            if (multiselect_ajax) { 
              data = [];
              $('[selected="selected"]', select).each(function(e) {
                data.push({
                  id: $(this).attr('value'),
                name: $(this).text()
                });
              });
            } else {
              data = {
                id: $(select.children()[0]).attr('value'),
                name: $(select.children()[0]).text()
              };
            }
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
            if (!multiselect_ajax) opt.remove();
            select.append($('<option></option>').attr('value', data.id).text(data.name));
          }
          if (multiselect_ajax) {
            $('option[value="'+data.id+'"]', select).attr('selected', true);
          } else {
            select.val(data.id);
          }
          
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
      
      console.log(select);
      $(inp).on("change", function(e) { console.log(e); if (e.removed) { $('option[value="'+e.removed.id+'"]', select).attr('selected', false); } })
      return $(this).hide();
    } else {
      if (typeof $(this).select2 == 'function') {
      return $(this).select2({
        maximumInputLength: 20,
        allowClear: true,
        placeholder: placeholder
      });
      }
    }
  });
}

function applyNavTabs(selector) {
  $(selector).click(function (e) {
  e.preventDefault();
  $(this).tab('show');
})
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

function hogan_template(template_name, params, partials) {
  return $($.parseHTML(HoganTemplates[template_name].render(params, partials)));
}

function alert_warning_template(title, description) {
  return hogan_template("alert_warning", {title: title, description: description}, {});
}

