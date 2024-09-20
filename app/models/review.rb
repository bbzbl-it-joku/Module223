class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :rating, presence: true, inclusion: { in: 1..5 }
  validates :review_text, presence: true, length: { minimum: 10 }
end
