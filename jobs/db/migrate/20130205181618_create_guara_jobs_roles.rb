class CreateGuaraJobsRoles < ActiveRecord::Migration
  def change
    create_table :guara_jobs_roles do |t|
      t.string :name
      t.integer :business_action_id

      t.timestamps
    end
  end
end
