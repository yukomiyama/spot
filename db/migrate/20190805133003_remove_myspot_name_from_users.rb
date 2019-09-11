class RemoveMyspotNameFromUsers < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :myspot_name, :string
  end
end
