class RemoveFromMyspotidFromArticles < ActiveRecord::Migration[5.2]
  def change
    remove_column :articles, :myspot_id, :integer
  end
end
