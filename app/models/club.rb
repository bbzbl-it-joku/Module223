class Club < ApplicationRecord
  belongs_to :current_book, class_name: "Book", optional: true
  belongs_to :created_by, class_name: "User"
  has_many :club_members
  has_many :users, through: :club_members
  has_many :reading_list_books
  has_many :books, through: :reading_list_books
  has_many :chats

  validates :name, presence: true, uniqueness: true, length: { in: 3..50 }
  validates :description, presence: true, length: { minimum: 10 }
end
