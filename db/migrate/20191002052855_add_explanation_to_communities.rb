class AddExplanationToCommunities < ActiveRecord::Migration[5.2]
  def change
    add_column :communities, :explanation, :string
  end
end
