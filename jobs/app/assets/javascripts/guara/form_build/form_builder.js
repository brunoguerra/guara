window.form_builder = {
    fields: {
        defaults: {
            text: {
                default_field: {
                    title: "Texto",
                    type_field: "text"
                },
                attrs_field: []
            },
            number: {
                default_field: {
                    title: "Número",
                    type_field: "number"
                },
                attrs_field: []
            },
            select: {
                default_field: {
                    title: "Caixa de Seleção",
                    type_field: "select",
                    options: ""
                },
                attrs_field: [
                    {type_field: "select_type", label: "Valores"}
                ]
            },
            date: {
                default_field: {
                    title: "Data",
                    type_field: "date"
                },
                attrs_field: []
            },
            time: {
                default_field: {
                    title: "Hora",
                    type_field: "time"
                },
                attrs_field: []
            },
            text_area: {
                default_field: {
                    title: "Caixa de Texto",
                    type_field: "text_area"
                },
                attrs_field: []
            },
            phone: {
                default_field: {
                    title: "Telefone",
                    type_field: "phone"
                },
                attrs_field: []
            },
            price: {
                default_field: {
                    title: "Valor Monetário",
                    type_field: "price"
                },
                attrs_field: []
            },
            widget: {
                default_field: {
                    title: "Customização de Campo",
                    type_field: "widget"
                },
                attrs_field: [
                    {type_field: "type_value", label: "Tipo"},
                    {type_field: "text_field_widget", label: "Widget"}
                ]
            }
        },

        defaults_config: {
            column: 1,
            id: '',
            resume: 1,
            required: 0,
            position: 0,
            title: "",
            type_field: "text",
            options: "",
            widget: "",
            group: ""
        },

        templates: {
            container_field: function(id_el, field, label){
                var me = form_builder.process.field.action;
                $('<li></li>')
                    .attr('id', id_el)
                    .addClass('drag')
                    .click(function(e){
                        me.select_element(this);
                    })
                    .append(
                        $('<a></a>')
                            .addClass('hover_ready')
                            .attr('href', 'javascript:void(0);')
                            .append(
                                $('<label></label>')
                                    .addClass('desc')
                                    .html(label)
                            )
                            .append(
                                $('<div></div>')
                                    .append(field)
                            )
                    )
                    .append(
                        $('<div></div>')
                            .addClass('element_actions')
                            .append(
                                $('<img/>')
                                    .attr('src', '/assets/img/delete.gif')
                                    .click(function(e){
                                        me.delete_element(id_el);
                                    })
                            )
                    )
                    .appendTo($('#container_form_fields'));
            },

            text: function(){
                return $('<input/>')
                    .attr('type', 'text')
                    .attr('readonly', 'readonly');
            },

            number: function(){
                return $('<input/>')
                    .attr('type', 'text')
                    .val('0123456')
                    .attr('readonly', 'readonly');
            },

            select: function(){
                return $('<select></select>')
                    .attr('readonly', 'readonly');
            },

            date: function(){
                return $('<input/>')
                    .attr('type', 'text')
                    .val('99/99/9999')
                    .addClass('mask', 'date')
                    .attr('readonly', 'readonly');
            },

            time: function(){
                return $('<input/>')
                    .attr('type', 'text')
                    .val('99:99')
                    .addClass('mask', 'time')
                    .attr('readonly', 'readonly');
            },

            phone: function(){
                return $('<input/>')
                    .attr('type', 'text')
                    .val('(99) 9999-9999')
                    .addClass('mask', 'phone')
                    .attr('readonly', 'readonly');
            },

            price: function(){
                return $('<input/>')
                    .attr('type', 'text')
                    .val('0,00')
                    .addClass('mask', 'price')
                    .attr('readonly', 'readonly');
            },

            text_area: function(){
                return $('<textarea></textarea>')
                    .attr('readonly', 'readonly');
            },

            widget: function(){
                return "";
            }
        }
    },

    properties_fields: {
        templates: {
            container: function(type, field, label){
                $('<li></li>')
                    .addClass('clear')
                    .append(
                        $('<label></label>')
                            .addClass('desc')
                            .attr('for', 'prop_'+type)
                            .html(label)
                    )
                    .append(field)
                    .appendTo($('#properties_fields'));
            },

            column: function(){
                var me = form_builder.process;
                return $('<select></select>')
                    .attr('id', 'prop_column')
                    .addClass('select')
                    .addClass('full')
                    .change(function(){
                        me.properties.set_config($(this).val(), 'column');
                    })
                    .append(
                        $("<option></option>")
                            .attr("value", 1)
                            .text("Coluna 1")
                    )
                    .append(
                        $("<option></option>")
                            .attr("value", 2)
                            .text("Coluna 2")
                    ); 
            },

            title: function(){
                var me = form_builder.process;
                return $('<input />')
                    .attr('type', 'text')
                    .attr('id', 'prop_title')
                    .addClass('text_field')
                    .keyup(function(){
                        me.properties.set_config($(this).val(), 'title');
                    });
            },

            group: function() {
              var me = form_builder.process;
              return $('<input />')
                  .attr('type', 'text')
                  .attr('id', 'prop_group')
                  .addClass('text_field')
                  .keyup(function(){
                      me.properties.set_config($(this).val(), 'group');
                  });
            },

            resume_and_required: function(){
                var me = form_builder.process;
                return $('<div></div>')
                    .append(
                        $('<label></label>')
                            .attr('for', 'prop_resume')
                            .addClass('inline')
                            .append(
                                $('<input />')
                                    .attr('id', 'prop_resume')
                                    .addClass('checkbox')
                                    .attr('type', 'checkbox')
                                    .val('')
                                    .change(function(){
                                        var checkVal = (this.checked) ? 1 : 0;
                                        me.properties.set_config(checkVal, 'resume');
                                    })
                            )
                            .append(' Resumo?')
                    )
                    .append(
                        $('<label></label>')
                            .attr('for', 'prop_required')
                            .addClass('inline')
                            .append(
                                $('<input />')
                                    .attr('id', 'prop_required')
                                    .addClass('checkbox')
                                    .attr('type', 'checkbox')
                                    .val('')
                                    .change(function(){
                                        var checkVal = (this.checked) ? 1 : 0;
                                        me.properties.set_config(checkVal, 'required');
                                    })
                            )
                            .append(' Campo Obrigatório')
                    );
            },

            select_type: function(){
                var me = form_builder.process;
                return $('<input />')
                    .attr('type', 'text')
                    .attr('id', 'prop_select_type')
                    .addClass('text_field')
                    .keyup(function(){
                        me.properties.set_config($(this).val(), 'select_type');
                    });
            },

            type_value: function(){
                var me = form_builder.process;
                return $('<select></select>')
                    .attr('id', 'prop_type_value')
                    .addClass('select')
                    .addClass('full')
                    .change(function(){
                        me.properties.set_config($(this).val(), 'type_value');
                    })
                    .append(
                        $("<option></option>")
                            .attr("value", '')
                            .text("Widget")
                    )
                    .append(
                        $("<option></option>")
                            .attr("value", 'component')
                            .text("Component")
                    );
            },

            text_field_widget: function(){
                var me = form_builder.process;
                return $('<input />')
                    .attr('type', 'text')
                    .attr('id', 'prop_widget')
                    .addClass('widget_field')
                    .keyup(function(){
                        me.properties.set_config($(this).val(), 'widget');
                    });
            },

            widget: function(){
                return "";
            }
        }
    },

    process: {
        id_sequence: 0,
        current_field_selected: null,
        elements_inserteds: [],

        clear_fields: function(){
            var me = this;
            me.id_sequence = 0;
            me.elements_inserteds = [];
            $('#container_form_fields').empty();
        },

        getJSON: function(){
            var me = this;
            var a  = me.elements_inserteds;
            var b  = [];
            var c  = [];

            for(var i=0;i<a.length;i++){
                b[a[i].position] = a[i];
            }

            for(var i=0;i<b.length;i++){
                if(a[i]){
                    c.push(a[i]);                
                }
            }

            return JSON.stringify(c);
        },

        field: {
            config: {
                get_config: function(id){
                    return this.get_config_or_index(id);
                },

                get_index: function(id){
                    return this.get_config_or_index(id, true);
                },

                get_config_or_index: function(id, return_index){
                    var elements  = form_builder.process.elements_inserteds,
                    index = null;
                    if(!isNaN(parseInt(id))){
                        id = "li_"+id;
                    }

                    for(var i=0; i < elements.length;i++){
                        if(id==elements[i].id){
                            index = i;
                        }
                    }

                    if(return_index){
                        return index;
                    }
                    else{
                        return form_builder.process.elements_inserteds[index];
                    }
                },

                load_config_field: function(type, position){
                    var me  = form_builder,
                    id_seq  = me.process.id_sequence,
                    fields  = me.fields;
                    config   = $.extend({}, fields.defaults_config, fields.defaults[type].default_field, {position: position, id: 'li_' + id_seq});
                    me.process.elements_inserteds.push(config);
                    me.process.id_sequence++;
                    return config;
                }
            },

            action: {
                delete_element: function(id){
                    var me = form_builder.process;
                    var element = me.field.config.get_index(id);
                    $('#'+id).remove();
                    me.elements_inserteds.splice(element, 1);
                    me.position.update();
                    $('#myTab a[href="#add_field"]').tab('show'); 
                },

                select_element: function(element) {
                    var me = form_builder.process;
                    this.unselect_elements();
                    $(element).addClass("current_edit");
                    var config = me.field.config.get_config($(element).attr('id'));
                    if(config){
                        me.properties.start(config);
                    }
                    else{
                        console.error("Config Not Found for element");
                        console.error(element);
                    }
                },

                unselect_elements: function() {
                    $('#container_form_fields li').removeClass("current_edit");
                }
            },

            insert: function(type, config){
                var me   = form_builder.process;
                var position = me.elements_inserteds.length;
                var config  = me.field.config.load_config_field(type, position);
                var field    = form_builder.fields.templates[type](config);
                form_builder.fields.templates.container_field(config.id, field, config.title);
            },

            update: function(config){
                var me       = form_builder.process;
                var elements = me.elements_inserteds;
                var els_size = (me.elements_inserteds.length - 1);

                elements[els_size].title - config.title;
                elements[els_size].column = config.column;
                elements[els_size].resume = config.resume;
                elements[els_size].required = config.required;
                elements[els_size].options = config.options;
                elements[els_size].widget = config.widget;
                elements[els_size].group = config.group;

                me.current_field_selected = elements_inserteds[els_size];
                me.properties.set_config(config.title, 'title');
                me.properties.set_config(config.required, 'required');
            }
        },

        position: {
            update: function(){
                var me     = this,
                containers = $('#container_form_fields li');

                for(var i=0;i<containers.length;i++){
                    me.set_position(containers[i].id, i);
                }

            },

            set_position: function(id, position){
                var element = form_builder.process.field.config.get_config(id);
                if(element){
                    element.position = position;
                }
            }
        },

        properties: {
            start: function(config){
                var process    = form_builder.process;
                var properties = form_builder.properties_fields.templates;
                process.current_field_selected = config;

                $('#myTab a[href="#properties_fields"]').tab('show'); 
                $('#properties_fields').empty();

                properties.container('title', properties['title'], 'Descrição do Campo');
                properties.container('column', properties['column'], 'Coluna');
                properties.container('resume_and_required', properties['resume_and_required'], 'Regras');

                var attr = form_builder.fields.defaults[config.type_field].attrs_field;
                if(attr){
                    for(var i=0;i<attr.length;i++){
                        properties.container(attr[i].type_field, 
                            properties[attr[i].type_field], attr[i].label);
                    }
                }

                properties.container('group', properties['group'], 'Grupo');
                $('<br>').appendTo($('#properties_fields'));
                this.set_fields(config);
            },

            set_fields: function(config){
                for(var i in config){
                    if(i=='options'){
                        var input = $('#prop_select_type');
                        if(config[i] == 'component'){
                            $('#prop_type_value').val('component');
                        }
                        else{
                            $('#prop_type_value').val('');
                        }
                    }
                    else{
                        var input = $('#prop_'+i);
                    }
                    if((i=='required' || i=='resume') && (input.prop)){
                        if(config[i]=='1'){
                            input.prop('checked', true);
                        }
                        else{
                            input.prop('checked', false);   
                        }
                    }
                    else if(input.val){
                        input.val(config[i]);
                    }
                }
            },

            set_config: function(val, type){
                var me  = this,
                process = form_builder.process,
                field   = process.current_field_selected,
                config  = process.field.config.get_config(field.id);
                if(val!=0 && !val){
                    return true;
                }
                if (val.replace) {
                    val = val.replace(/\\\"/g, "\\ \"")
                }

                if(type == 'title'){
                    config.title = val;
                    $('#'+field.id+' label.desc').html(val);
                    if($('#prop_required').prop('checked')){
                        config.required = 1;
                        me.set_required(field.id, 1);
                    }
                }
                else if(type == 'column'){
                    config.column = parseInt(val);
                }
                else if(type == 'group'){
                    config.group = val;
                }
                else if(type == 'resume'){
                    config.resume = val;
                }
                else if(type == 'required'){
                    config.required = val;
                    me.set_required(config.id, val);
                }
                else if(type == 'select_type' || type == 'options' || type == 'type_value'){
                    config.options = val;
                }
                else if(type == 'widget'){
                    config.widget = val;
                }
            },

            set_required: function(id, val){
                var me  = this,
                config  = form_builder.process.field.config.get_config(id),
                obj     = $('#'+id+' label.desc');

                if(val==1 && ($('#'+id+' label.desc span.required').length==0)){
                    obj.append(
                        $('<span></span>')
                            .html(' * ')
                            .addClass('required')
                            .css('color', 'red')
                    );
                }
                else{
                    obj.html(config.title);
                }
            }
        }
    }
};