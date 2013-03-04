window.form_builder = {
    id_seq: 0,

    opts_els: {
        column: 1,
        id: '',
        resume: 1,
        required: 0,
        position: 0,
        title: "",
        type_field: "text",
        options: "",
        widget: ""
    },

    elements_inserteds: [],

    default_opts: {
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
                options: "cargo"
            },
            attrs_field: [{type_field: "select_type", label: "Tipo"}]
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
            attrs_field: [{type_field: "text_field_widget", label: "Widget"}]
        }
    },

    templates_fields: {
        duplicate_element: function(i){
            console.info('No Action!');
        },

        delete_element: function(i){
            var element = form_builder.getEl(i);
            $('#li_'+i).remove();
            form_builder.elements_inserteds.splice(element, 1);
            form_builder.updatePositions();
        },

        container_field: function(id_el, field, label){
            var me = this;
            $('<li></li>')
                .attr('id', 'li_'+id_el)
                .addClass('drag')
                .click(function(e){
                    form_builder.select_element(this);
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
                                .attr('src', '/assets/img/duplicate.gif')
                                .click(function(e){
                                    me.duplicate_element(id_el);
                                })
                        )
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
    },

    options_elements_attributes: {
        me: function(){
            return form_builder;
        },

        current_field_selected: null,

        startProperties: function(config){
            var me1 = this;
            var me2 = me1.me();
            me1.current_field_selected = config;
            
            $('#myTab a[href="#properties_fields"]').tab('show'); 
            $('#properties_fields').empty();

            me1.defaults.container('title', me1.defaults['title'], 'Descrição do Campo');
            me1.defaults.container('column', me1.defaults['column'], 'Coluna');
            me1.defaults.container('resume_and_required', 
                me1.defaults['resume_and_required'], 'Regras');

            var attr = me2.default_opts[config.type_field].attrs_field;
            if(attr){
                for(var i=0;i<attr.length;i++){
                    me1.defaults.container(attr[i].type_field, 
                        me1.defaults[attr[i].type_field], attr[i].label);
                }
            }

            $('<br>').appendTo($('#properties_fields'));

            me1.getProperties(config);
        },

        setProperties: function(val, type){
            var me = this,
            field  = me.current_field_selected;
            config = me.me().getEl(field.id);
            if(!val){
                return true;
            }
            if (val.replace) {
                val = val.replace(/\\\"/g, "\\ \"")
            }

            if(type == 'title'){
                $('#'+field.id+' label.desc').html(val);
                config.title = val;
            }
            else if(type == 'column'){
                config.column = parseInt(val);
            }
            else if(type == 'resume'){
                config.resume = val;
            }
            else if(type == 'required'){
                config.required = val;
                me.set_required(config.id, val);
            }
            else if(type == 'select_type'){
                config.options = val;
            }
            else if(type == 'widget'){
                config.widget = val;
            }
        },

        set_required: function(id, val){
            var me     = this;
            var obj    = $('#'+id+' label.desc');
            var config = me.me().getEl(id);
            if(val==1){
                obj.append(
                    $('<span></span>')
                        .html(' * ')
                        .css('color', 'red')
                );
            }
            else{
                obj.html(config.title);
            }
        },

        getProperties: function(config){
            for( var i in config){
                if(i=='options'){
                    var input = $('#prop_select_type');
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

        defaults: {
            me: function(){
                return form_builder;
            },

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
                var me = form_builder;
                return $('<select></select>')
                    .attr('id', 'prop_column')
                    .addClass('select')
                    .addClass('full')
                    .change(function(){
                        me.options_elements_attributes.
                        setProperties($(this).val(), 'column');
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
                var me = form_builder;
                return $('<input />')
                    .attr('type', 'text')
                    .attr('id', 'prop_title')
                    .addClass('text_field')
                    .keyup(function(){
                        me.options_elements_attributes.
                        setProperties($(this).val(), 'title');
                    });
            },

            resume_and_required: function(){
                var me = form_builder;
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
                                        me.options_elements_attributes.
                                        setProperties(checkVal, 'resume');
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
                                        me.options_elements_attributes.
                                        setProperties(checkVal, 'required');
                                    })
                            )
                            .append(' Campo Obrigatório')
                    );
            },

            select_type: function(){
                var me = form_builder;
                return $('<select></select>')
                    .attr('id', 'prop_select_type')
                    .addClass('select')
                    .addClass('full')
                    .change(function(){
                        me.options_elements_attributes.
                        setProperties($(this).val(), 'select_type');
                    })
                    .append(
                        $("<option></option>")
                            .attr("value", 'role')
                            .text("Cargo")
                    )
                    .append(
                        $("<option></option>")
                            .attr("value", 'person_pf')
                            .text("Clientes")
                    )
                    .append(
                        $("<option></option>")
                            .attr("value", 'person_pj')
                            .text("Empresas")
                    ); 
            },

            text_field_widget: function(){
                var me = form_builder;
                return $('<input />')
                    .attr('type', 'text')
                    .attr('id', 'prop_widget')
                    .addClass('widget_field')
                    .keyup(function(){
                        me.options_elements_attributes.
                        setProperties($(this).val(), 'widget');
                    });
            },

            widget: function(){
                return "";
            }
        }
    },

    templates_insert_field: {
        
        container: function(type, text){
          $('<li></li>')
            .append(
                $('<a></a>')
                    .addClass('insert_elements')
                    .attr('type-el', type)
                    .attr('href', 'javascript:void(0);')
                    .attr('title', type)
                    .append(
                        $('<div></div>')
                            .addClass('helper-font-24')
                            .append(
                                $('<i></i>')
                                    .addClass(type)
                                    .append(
                                        $('<img/>')
                                            .attr('src', '/assets/img/'+type+'.gif')
                                    )
                            )
                    )
                    .append(
                        $('<span></span>')
                            .addClass('sidebar-text')
                            .text(text)
                    )
            )
        }
    },

    getEl: function(id){
        var me  = this,
        element = null;
        if(!isNaN(parseInt(id))){
            id = "li_"+id;
        }

        for(var i=0; i < me.elements_inserteds.length;i++){
            if(id==me.elements_inserteds[i].id){
                element = i;
            }
        }
        return me.elements_inserteds[element];
    },

    getConfigEl: function(id){
        var els = this.elements_inserteds;
        var config = null;
        for(var i=0;i< els.length;i++){
            if(els[i].id == id){
                config = els[i];
            }
        }

        return config;
    },

    getFieldConfig: function(type, position){
        var me = this;
        opts   = $.extend({}, me.opts_els, me.default_opts[type].default_field, {position: position, id: 'li_' + form_builder.id_seq});
        me.elements_inserteds.push(opts);
        form_builder.id_seq++;
        return opts;
    },

    select_element: function(el) {
        var me = this;
        me.unselect_elements();
        $(el).addClass("current_edit");
        var config = me.getConfigEl($(el).attr('id'));
        if(config){
            me.options_elements_attributes.startProperties(config);
        }
    },

    unselect_elements: function() {
        $('#container_form_fields li').removeClass("current_edit");
    },

    insert_el: function(type, config){
        var me   = this;
        var position = me.elements_inserteds.length;
        var config  = me.getFieldConfig(type, position);
        var field    = me.templates_fields[type](config);
        me.templates_fields.container_field(position, field, config.title);
    },

    update_el: function(config){
        var me  = this;
        var els = me.elements_inserteds;
        var att = me.options_elements_attributes;
        
        att.current_field_selected = els[els.length - 1];
        att.setProperties(config.title, 'title');
        att.setProperties(config.required, 'required');

        els[els.length - 1].title = config.title;
        els[els.length - 1].column = config.column;
        els[els.length - 1].resume = config.resume;
        els[els.length - 1].required = config.required;
        els[els.length - 1].select_type = config.select_type;
        els[els.length - 1].widget = config.widget;
    },

    updatePositions: function(){
        var me = this;
        var a  = me.elements_inserteds;  
        var b  = $('#container_form_fields li');

        for(var i=0;i<b.length;i++){
            console.info(b[i].id);
            me.setPosition(b[i].id, i);
        }
    },    

    setPosition: function(id, position){
        var me  = this,
        element = me.getEl(id);
        if(element){
            element.position = position;
        }
    },

    getJSON: function(){
        var me = this;
        var a  = me.elements_inserteds;
        var b  = [];

        for(var i=0;i<a.length;i++){
            b[a[i].position] = a[i];
        }

        return JSON.stringify(b);
    },

    clear_fields: function(){
        var me = this;
        me.id_seq = 0;
        me.elements_inserteds = [];
        $('#container_form_fields').empty();
    }
};