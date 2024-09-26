class Book < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :reading_list_books
  has_many :clubs, through: :reading_list_books
end
