class CreateGuaraJobsProfessionals < ActiveRecord::Migration
  def change
    create_table :guara_jobs_professionals do |t|
      t.integer :person_id
      t.boolean :have_job
      t.text :resume_professional
            
      t.timestamps
    end
  end
end
