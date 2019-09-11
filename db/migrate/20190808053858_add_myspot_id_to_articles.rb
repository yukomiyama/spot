class AddMyspotIdToArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :myspot_id, :integer
  end
end
