class ClubMember < ApplicationRecord
  belongs_to :club
  belongs_to :user

  validates :role, presence: true, inclusion: { in: ['member', 'moderator', 'admin'] }
  validates :joined_at, presence: true
end