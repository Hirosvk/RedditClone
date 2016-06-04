class CreateSubPosts < ActiveRecord::Migration
  def change
    create_table :sub_posts do |t|
      t.integer :sub_id, null: false
      t.integer :post_id, null: false

      t.timestamps null: false
    end
    add_index :sub_posts, [:sub_id, :post_id], unique: true
  end
end
