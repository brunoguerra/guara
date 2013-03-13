class CreateGuaraJobsLanguages < ActiveRecord::Migration
  def change
    create_table :guara_jobs_languages do |t|
    	
      t.string :name
      t.references :professional_language

      t.timestamps
    end
  end
end
