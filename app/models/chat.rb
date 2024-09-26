class Chat < ApplicationRecord
  belongs_to :club
  belongs_to :user

  validates :message, presence: true, length: { maximum: 1000 }
  validates :club_id, presence: true
  validates :user_id, presence: true

  default_scope { order(created_at: :asc) }
end
