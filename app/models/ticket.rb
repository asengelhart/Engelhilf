class Ticket < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :comment_authors, through: :comments, source: :user_id
end
