class ReadingListBook < ApplicationRecord
  belongs_to :club
  belongs_to :book

  validates :club_id, presence: true
  validates :book_id, presence: true, uniqueness: { scope: :club_id, message: "is already in the reading list" }
  validates :status, inclusion: { in: %w[to_read reading completed] }
  validates :added_at, presence: true

  after_create :set_default_status

  private

  def set_default_status
    self.update(status: "to_read") if status.blank?
  end
end
