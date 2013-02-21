class CreateGuaraJobsBusinessActions < ActiveRecord::Migration
  def change
    create_table :guara_jobs_business_actions do |t|
      t.string :name

      t.timestamps
    end
  end
end
