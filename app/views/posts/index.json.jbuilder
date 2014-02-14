json.array!(@posts) do |post|
  json.extract! post, :id, :content, :user_id
  json.url post_url(post, format: :json)
end
json.array!(@comments) do |comment|
  json.extract! comment, :id, :content, :user_id, :post_id
  json.url comment_url(comment, format: :json)
end