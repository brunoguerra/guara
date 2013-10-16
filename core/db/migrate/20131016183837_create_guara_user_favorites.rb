class CreateGuaraUserFavorites < ActiveRecord::Migration
  def change
    create_table :guara_user_favorites do |t|
      t.references :user
      t.references :thing

      t.timestamps
    end
    add_index :guara_user_favorites, :user_id
    add_index :guara_user_favorites, :thing_id
  end
end
