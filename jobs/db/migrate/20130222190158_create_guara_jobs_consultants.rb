class CreateGuaraJobsConsultants < ActiveRecord::Migration
  def change
    create_table :guara_jobs_consultants do |t|
      t.string :name
      t.boolean :enable

      t.timestamps
    end
  end
end
