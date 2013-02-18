class CreateGuaraJobsAbilities < ActiveRecord::Migration
  def change
    create_table :guara_jobs_abilities do |t|
      t.string :name

      t.timestamps
    end
  end
end
