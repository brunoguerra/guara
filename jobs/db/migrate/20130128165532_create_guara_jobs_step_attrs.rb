class CreateGuaraJobsStepAttrs < ActiveRecord::Migration
    def change
      create_table :guara_jobs_step_attrs do |t|
        t.string   :label
        t.string   :position
        t.string   :guidelines
        t.string   :options
        t.string   :type_field
        t.boolean  :resume
        t.boolean  :required
        t.integer  :column
        t.integer  :step_id
        
        t.timestamps
      end
    end
end
