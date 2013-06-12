module Guara
  module ActiveCrm
  	module ScheculedsHelper

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
  			search[:customer_guara_customer_pj_type_activities_id_in] = record.business_activities.split(',') if !record.business_activities.empty?
  			search[:customer_guara_customer_pj_type_activities_business_segment_id_in] = record.business_segments.split(',') if !record.business_segments.empty?
  			search["customer_guara_customer_pj_type_total_employes_btw(1)"] = record.employes_min if !record.employes_min.nil?
  			search["customer_guara_customer_pj_type_total_employes_btw(2)"] = record.employes_max if !record.employes_max.nil?
  			search[:name_contains] = record.name_contains if !record.name_contains.empty?
  			search[:finished_id] = record.finished_id if !record.finished_id.nil?
  			search[:pair_or_odd_id] = record.pair_or_odd if !record.pair_or_odd.empty?
  			search[:doc_equals] = record.doc_equals if !record.doc_equals.empty?
  			search[:district_name_contains] = record.district_contains if !record.district_contains.empty?
        
  			return search
  		end

      def table_tr_filter(label, value)
        raw("<tr><td><strong>#{label}:</strong> #{value}</td></tr>")
      end

  	end
  end
end
