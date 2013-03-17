class CreateGuaraJobsLevelKnowledges < ActiveRecord::Migration
  def change
    create_table :guara_jobs_level_knowledges do |t|
      t.string :name

      t.timestamps
    end
  end
end
