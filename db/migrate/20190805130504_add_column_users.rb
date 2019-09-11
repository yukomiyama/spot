class AddColumnUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :myspot_name, :string
  end
end
