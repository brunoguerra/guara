# This migration comes from guara_jobs (originally 20130207143204)
class CreateGuaraJobsProfessionals < ActiveRecord::Migration
  def change
    create_table :guara_jobs_professionals do |t|
      t.integer :person_id
            
      t.timestamps
    end
  end
end
