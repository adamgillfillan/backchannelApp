class User < ActiveRecord::Base
  has_many :posts
  validates :name, presence: true
  REGEX_EMAIL = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: REGEX_EMAIL },
            uniqueness: { case_sensitive: false } #ensures a unique, case-insesitive email
end
