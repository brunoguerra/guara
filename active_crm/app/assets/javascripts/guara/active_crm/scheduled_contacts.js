  var ScheduledContacts = {
    current_customer: null,
    ignored_customers: null,
    new_scheduled_contacts: null,
    javascript_crm: null,
    container_customer: $('#dialog-modal-customer'),
    container_call: $('#dialog-modal-call'),

    init: function(ignored_customers, new_scheduled_contacts){
      var me = this;
      if(ignored_customers){
        me.ignored_customers = ignored_customers;
      }
      if(new_scheduled_contacts){
        me.new_scheduled_contacts = new_scheduled_contacts; 
      }
      $('#container_table #customer-to-register tbody tr').click(function(){
        me.open_dialog_customer($(this));
      });
    },

    reorganize_view_customer: function(){
      var clone = $('.container-contacts').clone();
      $('.container-contacts').remove();
      $('.container-thumbnails').append(clone);
      $('.box-white-data.activities').width(210);
    },

    open_dialog_customer: function(tr){
      var me = this;
      me.current_customer = tr.attr('customer-id');
      me.container_customer.html('Carregando...')
      .dialog({
        modal: true,
        draggable: false,
        height: ($(window).height() - 60),
        width: ($(window).width() - 100),
        open: function( event, ui ) {
          var container = $(me.container_customer.parent('div.ui-dialog.ui-widget'));
          container
            .css('top', '50px')
            .css('position', 'fixed');
        },
        buttons: [
          {
              text: "Próximo Cliente",
              'class': 'saveButtonClass',
              click: function() {
                  me.ignored_customers.push(me.current_customer);
                  $.ajax({
                    type: "GET",
                    url: "/ignore_customer_session",
                    data: {
                      customer_id: me.current_customer
                    }
                  }).done(function( data ) {
                    
                  });
                  me.next_customer();
              }
          }
        ]
      })
      .load('/customers/'+ tr.attr('customer-id')+'.json', function(){
        me.reorganize_view_customer();
        $('select.multiselect').removeClass('multiselect');
        me.initialize_js_customer();
        me.call_container_contacts();
      });
    },

    call_container_contacts: function(){
      var me = this;
      $('.container-contacts table tr[contact-id]').click(function(){
        me.open_dialog_call($(this).attr('contact-id'));
      });
      $('.container-contacts table tr[contact-id] td a.btn').remove();
    },

    get_fields: function(form){
      var data_fields = {};
      form.find('input,select').each(function(){
        if(!data_fields[$(this).attr('name')]){
          data_fields[$(this).attr('name')] = $(this).val();
        }
      });

      return data_fields;
    },

    form_customer_submit: function(){
      var me = this;
      $('form.guara_customer').on('submit', function(e){
        e.preventDefault();
        var data_fields = me.get_fields($('form.guara_customer'));
        
        $.ajax({
          type: "POST",
          dataType : 'script',
          url : $('form.guara_customer').attr('action')+'.js',
          data: data_fields,
          success : function(script){
            me.form_customer_submit();
            me.call_container_contacts();
          }
        });

      });
    },

    form_customer_contacts: function(){
      $('form').on('click', '.remove_fields', function(event) {
          event.preventDefault();
          
          $(this).prev('input[type=hidden]').val('1');
          $(this).closest('fieldset').hide();
        });
        $('form, div.list_nested_form').on('click', '.add_fields', function(event) {
          event.preventDefault();

          var regexp, time;
          time = new Date().getTime();
          regexp = new RegExp($(this).data('id'), 'g');
          $(this).before($(this).data('fields').replace(regexp, time));
          $('select.multiselect').select2('destroy');

        });
    },

    initialize_js_customer: function(){
      var me = this;
      me.form_customer_submit();
      me.form_customer_contacts();
    },

    open_dialog_call: function(contact_id){
      var me = this;
      if($('.tab-content #index div#dialog-call').length==0){
        $('.tab-content #index').append('<div id="dialog-call"></div>');
      }

      $('.tab-content #index div#dialog-call').html('Carregando...').load(me.new_scheduled_contacts+'?contact_id='+contact_id, function(){
        $('#dialog-modal-customer').animate({
          scrollTop: $('#btn-completed-call').offset().top
        });
      });
    },

    is_customer_ignored: function(customer_id){
      var me     = this,
      is_ignored = false,
      ignoreds   = me.ignored_customers;
      
      for(var i in ignoreds){
        if(customer_id == ignoreds[i]){
          is_ignored = true;
        }
      }
      return is_ignored;
    },

    next_customer: function(){
      var me = this,
      next_customer = false;
      $('#container_table #customer-to-register tbody tr').each(function(){
        if(next_customer === false){
          if(me.is_customer_ignored($(this).attr('customer-id')) === false){
            me.current_customer = $(this).attr('customer-id');
            next_customer = true;
            me.open_dialog_customer($(this));
          }
        }
      });

      if(me.is_customer_ignored(me.current_customer) === true){
        alert('Todos os Clientes foram Ignorados nesta sessão!');
      }
    }
  };

  function paginate_call(){
    $('.pagination a').each(function(){
      if($(this).attr('href').match('.js?') === false){
        var url = $(this).attr('href').replace('?', '.js?');
      }
      else{
        var url = $(this).attr('href');
      }
      $(this).attr('href', url)
      .click(function(e){
        e.preventDefault();
        var url = $(this).attr('href');
        
        $.ajax({
          dataType : 'script',
          url : url,
          success : function(script){
            paginate_call();
            ScheduledContacts.init();
          }
        });
      });
    });
  }