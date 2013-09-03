module Guara
  module ActiveCrm
  	module ScheduledsHelper

  		def prepare_filter_save(search, scheduled_id)
  			search[:customer_guara_customer_pj_type_activities_business_segment_id_in].delete_if {|hash| hash.to_s.empty?} if !search[:customer_guara_customer_pj_type_activities_business_segment_id_in].nil?
            search[:customer_guara_customer_pj_type_activities_id_in].delete_if {|hash| hash.to_s.empty?} if !search[:customer_guara_customer_pj_type_activities_id_in].nil?
            
            {
                :scheduled_id=> scheduled_id,
                :business_activities=> (search[:customer_guara_customer_pj_type_activities_id_in].nil? ? nil : search[:customer_guara_customer_pj_type_activities_id_in].join(',')),
                :business_segments=> (search[:customer_guara_customer_pj_type_activities_business_segment_id_in].nil? ? nil : search[:customer_guara_customer_pj_type_activities_business_segment_id_in].join(',')),
                :employes_min=> (search["customer_guara_customer_pj_type_total_employes_btw(1)"].nil? ? nil : search["customer_guara_customer_pj_type_total_employes_btw(1)"]),
                :employes_max=> (search["customer_guara_customer_pj_type_total_employes_btw(2)"].nil? ? nil : search["customer_guara_customer_pj_type_total_employes_btw(2)"]),
                :name_contains=> (search[:name_contains].nil? ? nil : search[:name_contains]),
                :finished_id=> (search[:finished_id].nil? ? nil : search[:finished_id]),
                :pair_or_odd=> (search[:pair_or_odd_id].nil? ? nil : search[:pair_or_odd_id]),
                :doc_equals=> (search[:doc_equals].nil? ? nil : search[:doc_equals]),
                :district_contains=> (search[:district_name_contains].nil? ? nil : search[:district_name_contains])
            }
  		end

  		def prepare_filter_search(search, record)
  			search[:customer_guara_customer_pj_type_activities_id_in] = record.business_activities.split(',') if !record.business_activities.nil? && !record.business_activities.empty?
  			search[:customer_guara_customer_pj_type_activities_business_segment_id_in] = record.business_segments.split(',') if !record.business_activities.nil? && !record.business_segments.empty?
  			search["customer_guara_customer_pj_type_total_employes_btw(1)"] = record.employes_min || 0
  			search["customer_guara_customer_pj_type_total_employes_btw(2)"] = record.employes_max if !record.employes_max.nil?
        search["customer_guara_customer_pj_type_total_employes_btw(2)"] = 9999999 if record.employes_max.nil? && !record.employes_min.nil?
  			search[:name_contains] = record.name_contains if !record.name_contains.nil? && !record.name_contains.empty?
  			search[:finished_id] = record.finished_id if !record.finished_id.nil?
  			search[:pair_or_odd_id] = record.pair_or_odd if !record.pair_or_odd.nil? && !record.pair_or_odd.empty?
  			search[:doc_equals] = record.doc_equals if !record.doc_equals.nil? && !record.doc_equals.empty?
  			search[:district_name_contains] = record.district_contains if !record.district_contains.nil? && !record.district_contains.empty?
        
  			return search
  		end

      def table_tr_filter(label, value)
        raw("<tr><td><strong>#{label}:</strong> #{value}</td></tr>")
      end

      def search_scheduled(params)
        search = {}
        search[:task_type_id_in] = params[:group_scheduled_task_type_id_in] if !params[:group_scheduled_task_type_id_in].nil?
        search[:date_start_gteq] = params[:group_scheduled_date_start_gteq] if !params[:group_scheduled_date_start_gteq].nil?
        search[:date_start_lteq] = params[:group_scheduled_date_start_lteq] if !params[:group_scheduled_date_start_lteq].nil?
        search[:user_id_in]      = params[:group_scheduled_user_id_in]      if !params[:group_scheduled_user_id_in].nil?
        return search
      end

      def load_scheduleds_select(params)
        search = search_scheduled(params)
        if search.empty?
          return Scheduled.limit(25).search(search).order(:id)
        else
          return Scheduled.search(search).order(:id)
        end
      end

      def load_group_select(params)
        if params[:group_scheduled_id_in].nil? or params[:group_scheduled_id_in].empty?
            return Scheduled::Group.order(:id).limit(25)
        else
            return Scheduled::Group.where(:scheduled_id=> params[:group_scheduled_id_in]).order(:id).limit(25)
        end
      end

      def load_customer_select(params)
        if params[:group_scheduled_id_in].nil? or params[:group_scheduled_id_in].empty?
          return Guara::Customer.where(customer_type: 'Guara::CustomerPj').limit(25)
        else
          params_search = prepare_filter_search({}, Guara::ActiveCrm::Scheduled::Group.find(params[:id])) if params[:search].nil?
          filter_multiselect params_search, :customer_guara_customer_pj_type_activities_business_segment_id_in
          filter_multiselect params_search, :customer_guara_customer_pj_type_activities_id_in
          
          return Guara::Customer.customer_contact(params[:group_scheduled_id_in]).search(params_search)

        end
      end

  	end
  end
end
