class User < ApplicationRecord
  has_secure_password
  has_many :tickets
  has_many :comments
  has_many :commented_tickets, through: :comments, source: :ticket

  validates :username, presence: true, uniqueness: true
  validates :email, presence: true, uniqueness: true

  def self.admins
    where(is_admin: true)
  end
end
