class Ticket < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :comment_authors, through: :comments, source: :user
  validates :user, presence: true
  validates :content, presence: true

  def closed?
    !!closed_at
  end
end
