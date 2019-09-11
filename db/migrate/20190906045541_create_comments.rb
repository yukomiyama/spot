class CreateComments < ActiveRecord::Migration[5.2]
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.integer :article_id

      t.timestamps
      # add_index :user_id
      # add_index :article_id
    end
  end
end
