class AddUserIdToCommunities < ActiveRecord::Migration[5.2]
  def change
    add_column :communities, :user_id, :integer
  end
end
