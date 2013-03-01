# This migration comes from guara_jobs (originally 20130128165532)
class CreateGuaraJobsStepAttrs < ActiveRecord::Migration
    def change
      create_table :guara_jobs_step_attrs do |t|
        t.string   :title
        t.string   :position
        t.string   :options
        t.string   :widget
        t.string   :type_field
        t.boolean  :resume
        t.boolean  :required
        t.integer  :column
        t.integer  :step_id
        
        t.timestamps
      end
    end
end
