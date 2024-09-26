class Book < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :reading_list_books
  has_many :clubs, through: :reading_list_books

  validates :status, inclusion: { in: ["to_read", "reading", "completed"] }
  validates :book_id, uniqueness: { scope: :club_id }
  validates :added_at, presence: true
  after_create :set_default_status

  private

  def set_default_status
    self.update(status: "to_read") if status.blank?
  end
end
