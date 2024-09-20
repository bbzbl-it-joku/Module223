class Chat < ApplicationRecord
  belongs_to :club
  belongs_to :user

  validates :message, presence: true, length: { maximum: 1000 }
end
