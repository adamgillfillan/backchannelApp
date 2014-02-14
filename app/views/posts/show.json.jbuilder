json.extract! @post, :id, :content, :user_id, :created_at, :updated_at
json.extract! @comments, :id, :content, :user_id, :post_id, :created_at, :updated_at

