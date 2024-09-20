class Book < ApplicationRecord
  has_many :reviews
  has_many :reading_list_books
  has_many :clubs, through: :reading_list_books
  has_many :clubs_as_current_book, class_name: 'Club', foreign_key: 'current_book_id'

  validates :title, presence: true
  validates :author, presence: true
  validates :isbn, presence: true, uniqueness: true
  validates :publish_date, presence: true
end