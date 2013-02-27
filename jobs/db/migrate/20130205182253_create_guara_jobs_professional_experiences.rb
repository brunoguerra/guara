class CreateGuaraJobsProfessionalExperiences < ActiveRecord::Migration
  def change
    create_table :guara_jobs_professional_experiences do |t|
      
      t.string :company_name
      t.references :professional

      t.timestamps
    end
  end
end
