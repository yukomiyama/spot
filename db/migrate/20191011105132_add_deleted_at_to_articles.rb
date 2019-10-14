class AddDeletedAtToArticles < ActiveRecord::Migration[5.2]
  def change
    add_column :articles, :deleted_at, :datetime, :null => false, :default => 'Tokyo'
  end
end
