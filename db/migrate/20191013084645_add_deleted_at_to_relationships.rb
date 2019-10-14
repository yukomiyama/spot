class AddDeletedAtToRelationships < ActiveRecord::Migration[5.2]
  def change
    add_column :relationships, :deleted_at, :datetime
  end
end
