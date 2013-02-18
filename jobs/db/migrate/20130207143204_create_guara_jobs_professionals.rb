class CreateGuaraJobsProfessionals < ActiveRecord::Migration
  def change
    create_table :guara_jobs_professionals do |t|
      t.integer :person_id
      t.references :formation
      t.references :professional_experience
      t.references :vacancy_specification
      
      t.timestamps
    end
  end
end
