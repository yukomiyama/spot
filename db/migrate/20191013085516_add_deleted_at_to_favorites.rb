class AddDeletedAtToFavorites < ActiveRecord::Migration[5.2]
  def change
    add_column :favorites, :deleted_at, :datetime
  end
end
