class CreateGuaraJobsFormations < ActiveRecord::Migration
  def change
    create_table :guara_jobs_formations do |t|
      t.references :level_education
      t.string :course
      t.string :situation
      t.text :description
      t.string :name_institution
      t.date :date_conclusion
      t.references :professional

      t.timestamps
    end

  end
end
