class AddColumnProfileUpdatedAtToGuaraJobsProfessional < ActiveRecord::Migration
  def change
    add_column :guara_jobs_professionals, :profile_updated_at, :datetime

    Guara::Jobs::Professional.update_all("profile_updated_at = created_at")
  end
end
