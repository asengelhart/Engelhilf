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
    # Covers various ways of signifying true or false
    if [true, "true", 1, "1"].include?(closed)
      self.closed_at = Time.zone.now
    elsif [false, "false", 0, "0"].include(closed)
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

  def self.by_urgency_level(levels)
    where(urgency: levels)
  end

  def self.open_or_closed_tickets(status)
    if status == "open"
      where(closed_at: nil)
    elsif status == "closed"
      where.not(closed_at: nil)
    else
      unscope(where: :closed_at)
    end
  end

  def self.filter_tickets(params)
    tickets = self.all
    if params[:urgency_levels] && !params[:urgency_levels].blank?
      tickets = tickets.by_urgency_level(params[:urgency_levels])
    end
    if params[:open_or_closed]
      if params[:open_or_closed] == "open"
        tickets = tickets.open_tickets
      elsif params[:open_or_closed] == "closed"
        tickets = tickets.closed_tickets
      end
    end
    tickets
  end
end
