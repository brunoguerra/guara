class AddHaveJobToJobsProfessionals < ActiveRecord::Migration
  def change
  	add_column :guara_jobs_professionals, :have_job, :boolean
  end
end
