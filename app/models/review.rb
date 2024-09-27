class Review < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :user_id, presence: true
  validates :book_id, presence: true
  validates :rating, presence: true, inclusion: { in: 1..5 }
  validates :review_text, length: { minimum: 5, maximum: 2000 }
end
