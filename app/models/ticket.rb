class Ticket < ApplicationRecord
  belongs_to :user
  has_many :comments
  has_many :comment_authors, through: :comments, source: :user
  validates :user, presence: true
  validates :content, presence: true
  validates :urgency, presence: true, numericality: {only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 2}
  accepts_nested_attributes_for :comments, reject_if: proc {|attrs| attrs[:content].blank?}

  def closed
    !!closed_at
  end

  def closed=(closed)
    if closed == true
      self.closed_at = Time.zone.now
    elsif closed == false
      self.closed_at = nil
    end
  end

  def self.urgency_levels
    {
      0 => "It's an annoyance.",
      1 => "It's hurting my productivity.",
      2 => "I can't work because of this."
    }
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

  def self.open_tickets
    where(cldosed_at: nil)
  end
end
