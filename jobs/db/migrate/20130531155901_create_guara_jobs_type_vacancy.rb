class CreateGuaraJobsTypeVacancy < ActiveRecord::Migration
  def change
    create_table :guara_jobs_type_vacancy do |t|

      t.timestamps
    end

  end
end
