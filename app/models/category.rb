class Category < ActiveRecord::Base
  has_and_belongs_to_many :posts
  has_many :category_posts
end