class Book < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :reading_list_books
  has_many :clubs, through: :reading_list_books

  validates :title, presence: true
  validates :author, presence: true
  validates :isbn, uniqueness: true, format: { with: /\A(?=(?:\D*\d){10}(?:(?:\D*\d){3})?$)[\d-]+\z/, message: "must be a valid ISBN" }, allow_blank: true
  validates :publish_date, presence: true
  validates :description, length: { maximum: 2000 }
end
