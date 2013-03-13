class AddAttachmentAvatarFileToAttachments < ActiveRecord::Migration
  def self.up
    add_column :attachments, :avatar_file_name, :string
    add_column :attachments, :avatar_content_type, :string
    add_column :attachments, :avatar_file_size, :integer
    add_column :attachments, :avatar_updated_at, :datetime

    add_column :attachments, :curriculum_file_name, :string
    add_column :attachments, :curriculum_content_type, :string
    add_column :attachments, :curriculum_file_size, :integer
    add_column :attachments, :curriculum_updated_at, :datetime
  end

  def self.down
    remove_column :attachments, :avatar_file_name
    remove_column :attachments, :avatar_content_type
    remove_column :attachments, :avatar_file_size
    remove_column :attachments, :avatar_updated_at
    
    remove_column :attachments, :curriculum_file_name
    remove_column :attachments, :curriculum_content_type
    remove_column :attachments, :curriculum_file_size
    remove_column :attachments, :curriculum_updated_at
  end
end
