class Ticket < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :comment_authors, through: :comments, source: :user
  validates :user, presence: true
  validates :content, presence: true
  validates :urgency, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 2}

  def closed?
    !!closed_at
  end

  def self.only_an_annoyance
    where(urgency: 0)
  end

  def self.hurts_productivity
    where(urgency: 1)
  end

  def self.halts_work
    where(urgency: 2)
  end
end
