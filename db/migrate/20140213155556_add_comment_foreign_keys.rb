class AddCommentForeignKeys < ActiveRecord::Migration
  def change
    add_index :comments, :user_id
    add_index :comments, :post_id
    create_join_table :users, :posts, table_name: :post_votes do|t|
      t.index :user_id
      t.index :post_id
    end
    create_join_table :users, :comments, table_name: :comment_votes do|t|
      t.index :user_id
      t.index :comment_id
    end
  end
end
