class Club < ApplicationRecord
  belongs_to :current_book, class_name: "Book", optional: true
  belongs_to :created_by, class_name: "User", foreign_key: "created_by_id"

  has_many :club_members, dependent: :destroy
  has_many :users, through: :club_members
  has_many :reading_list_books, -> { order(created_at: :desc) }, dependent: :destroy
  has_many :books, through: :reading_list_books
  has_many :chats, dependent: :destroy


  validates :name, presence: true, uniqueness: true, length: { maximum: 100 }
  validates :description, presence: true, length: { maximum: 1000 }
  validates :created_by_id, presence: true
end
