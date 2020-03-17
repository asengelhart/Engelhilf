class User < ApplicationRecord
  has_secure_password
  has_many :posts
  has_many :comments
  has_many :commented_posts, through: :comments, source: :post

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true
end
