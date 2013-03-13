class CreateGuaraJobsProfessionalLanguages < ActiveRecord::Migration
  def change
    create_table :guara_jobs_professional_languages do |t|
      t.references :language
      t.references :level_knowledge
      t.references :professional

      t.timestamps
    end
  end
end
