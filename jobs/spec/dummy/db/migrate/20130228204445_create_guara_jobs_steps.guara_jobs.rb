# This migration comes from guara_jobs (originally 20130128165323)
class CreateGuaraJobsSteps < ActiveRecord::Migration
  	def change
	    create_table :guara_jobs_steps do |t|
	      t.string 	 :name
	      t.integer  :next
	      t.integer  :level
	      t.integer  :custom_process_id

	      t.timestamps
	    end
  	end
end
