class AddDeletedAtToTags < ActiveRecord::Migration[5.2]
  def change
    add_column :tags, :deleted_at, :datetime
  end
end
