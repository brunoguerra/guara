class CreateGuaraUserGoogle < ActiveRecord::Migration
  def change
    create_table :guara_user_google do |t|
      t.string :identifier, :length => 60
      t.string :link, :length => 200
      t.string :name, :length => 120
      t.string :picture, :length => 200
      t.string :token, :length => 250
      t.string :gender, :length => 12
      t.string :locale, :length => 20
      t.references :user

      t.timestamps
    end

    add_index :guara_user_google, :user_id
  end
end
