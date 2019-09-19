class RemoveArticleIdFromTags < ActiveRecord::Migration[5.2]
  def change
    remove_column :tags, :article_id, :integer
  end
end
