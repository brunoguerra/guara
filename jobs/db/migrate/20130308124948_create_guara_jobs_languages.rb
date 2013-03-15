class CreateGuaraJobsLanguages < ActiveRecord::Migration
  def change
    create_table :guara_jobs_languages do |t|
      t.string :name

      t.timestamps
    end
  end
end
