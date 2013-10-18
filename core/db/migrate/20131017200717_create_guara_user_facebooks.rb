class CreateGuaraUserFacebooks < ActiveRecord::Migration
  def change
    create_table :guara_user_facebooks do |t|
      t.references :user
      t.string :name
      t.string :identifier
      t.string :picture
      t.string :link
      t.string :token
      t.string :description

      t.timestamps
    end
    add_index :guara_user_facebooks, :user_id
  end
end
