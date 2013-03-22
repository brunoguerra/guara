class AddReleasedAndSourceIdToJobsCustomProcess < ActiveRecord::Migration
  def change
  	add_column :guara_jobs_custom_processes, :released,  :boolean
  	add_column :guara_jobs_custom_processes, :source_id, :integer
  end
end
