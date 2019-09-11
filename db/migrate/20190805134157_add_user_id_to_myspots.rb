class AddUserIdToMyspots < ActiveRecord::Migration[5.2]
  def change
    add_column :myspots, :user_id, :integer
  end
end
