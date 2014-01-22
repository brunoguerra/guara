class AddExternalIdToGuaraPlaces < ActiveRecord::Migration
  def change
    add_column :guara_places, :external_id, :string
  end
end
