module GuaraJobs
  module ProcessInstanceHelper

  	def getCollection(alias_model, id)
		#Retornar Model de Clientes ou Empresas
		if alias_model == 'person_pf'
            Guara::Jobs::Step.all.map{ |c| [c.name, c.id] }
		elsif alias_model == 'person_pj'
            Guara::Jobs::Step.all.map{ |c| [c.name, c.id] }
		end				
	end

	def show_label_tag(label)
      label_tag label, label+":", :class => "strong"
    end

    def show_span_tag(text)
    	content_tag(:span, text+":", :class => "strong")
    end

    def get_field(form, rec, val)
    	@field = ""
    	if rec.type_field == 'date'
		    @field = form.text_field rec.id, :class=> "input-block-level date_format", :value=> val[rec.id]
		elsif rec.type_field == 'textarea'
		    @field = form.text_area rec.id, :rows=>"6", :class=> "input-block-level", :value=> val[rec.id]
        elsif rec.type_field == 'select'
            @field = form.select rec.id, getCollection(rec.options), {:include_blank => true}, :class=> "input-block-level"
        else
            @field = form.text_field rec.id, :value=> val[rec.id], :class=> "input-block-level"
    	end

    	return "<div class=\"control-group\">
    			<label class=\"control-label strong\" for=\"#{rec.id}\">#{rec.label} #{'<span style="color:red">*</span>' if rec.required == true}</label>
			        <div class=\"controls\">
						#{@field}
					</div>
				</div>"
    end

    def get_fields(form, steps, vals, column)
    	@steps_attrs_column = []
    	if steps[column] != nil
	    	steps[column].each do |s|
	    		@steps_attrs_column << get_field(form, s, vals)
	    	end
    	end
    	return @steps_attrs_column.join("").html_safe
    end

    def get_required_fields(step_attrs)
        @required_fields = []
        step_attrs.each do |a,b|
            b.each do |c|
                @required_fields << "if(jQuery.trim($('#step_instance_attrs_#{c.id}').val())== '') {alert('Preencha o campo #{c.label}');return false;};"
            end
        end

        return @required_fields.join("").html_safe
    end

    def show_value_field(rec, vals)
        if rec.type_field == 'select'
            #vals[rec.id] = getCollection
        end
    end

  end
end
