class CreateGuaraJobsProfessionalExperiences < ActiveRecord::Migration
  def change
    create_table :guara_jobs_professional_experiences do |t|
      t.string :company_name
      t.string :role
      t.date :date_admission
      t.date :date_resignation
      t.decimal :salary, :precision => 10, :scale => 2, :default => 0
      t.text :activities
      t.references :professional

      t.timestamps
    end
  end
end
