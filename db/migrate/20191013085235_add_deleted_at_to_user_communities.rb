class AddDeletedAtToUserCommunities < ActiveRecord::Migration[5.2]
  def change
    add_column :user_communities, :deleted_at, :datetime
  end
end
