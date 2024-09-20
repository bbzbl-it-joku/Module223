class User < ApplicationRecord
  has_many :reviews
  has_many :club_members
  has_many :clubs, through: :club_members
  has_many :chats
  has_many :created_clubs, class_name: "Club", foreign_key: "created_by_id"

  validates :username, presence: true, uniqueness: true, length: { in: 3..30 }
  validates :email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password_hash, presence: true
end
