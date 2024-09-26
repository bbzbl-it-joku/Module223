class ReadingListBook < ApplicationRecord
  belongs_to :club
  belongs_to :book

  validates :status, inclusion: { in: [ "to_read", "reading", "completed" ] }
  validates :book_id, uniqueness: { scope: :club_id }
  validates :added_at, presence: true

  after_create :set_default_status

  private

  def set_default_status
    self.update(status: "to_read") if status.blank?
  end
end
