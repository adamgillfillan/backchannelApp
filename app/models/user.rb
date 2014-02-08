class User < ActiveRecord::Base
  attr_accessor :password
  before_save :encrypt_password

  has_many :posts
  validates :name, presence: true
  REGEX_EMAIL = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: REGEX_EMAIL },
            uniqueness: { case_sensitive: false } #ensures a unique, case-insesitive email
  validates_confirmation_of :password
  validates_presence_of :password, :on => :create

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

end
