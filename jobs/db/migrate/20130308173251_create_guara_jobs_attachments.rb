class CreateGuaraJobsAttachments < ActiveRecord::Migration
  def change
    create_table :guara_jobs_attachments do |t|
    	t.references :professional

    	t.string :avatar_file_name
    	t.string :avatar_content_type
    	t.integer :avatar_file_size
    	t.datetime :avatar_updated_at

    	t.string :curriculum_file_name
    	t.string :curriculum_content_type
    	t.integer :curriculum_file_size
    	t.datetime :curriculum_updated_at

      t.timestamps
    end
  end
end
