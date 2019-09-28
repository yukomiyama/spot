class AddFavoritesCountToArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :favorites_count, :integer, null: false, default: 0, comment: "いいね数"
  end
end
