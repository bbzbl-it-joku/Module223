class ClubMember < ApplicationRecord
  belongs_to :club
  belongs_to :user

  validates :club_id, presence: true
  validates :user_id, presence: true, uniqueness: { scope: :club_id, message: "is already a member of this club" }
  validates :role, inclusion: { in: %w[MEMBER ADMIN] }
end
