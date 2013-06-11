class RenameScheduled < ActiveRecord::Migration
  	def change
        rename_table :guara_active_crm_scheduleds, :guara_active_crm_scheduled_scheduleds
   	end 
end
