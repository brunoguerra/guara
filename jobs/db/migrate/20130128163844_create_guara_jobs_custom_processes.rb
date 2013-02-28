class CreateGuaraJobsCustomProcesses < ActiveRecord::Migration
	def change
    	create_table  :guara_jobs_custom_processes do |t|
    		t.string  :name
    		t.string  :hook_instanciate
    		t.integer :business_id
    		t.integer :step_init
    		t.boolean :enabled

      		t.timestamps
    	end
  	end
end
