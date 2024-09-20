class ReadingListBook < ApplicationRecord
  belongs_to :club
  belongs_to :book

  validates :status, presence: true, inclusion: { in: ['to_read', 'reading', 'completed'] }
end