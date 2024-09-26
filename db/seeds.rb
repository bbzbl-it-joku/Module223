# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Create a default user
User.find_or_create_by!(username: 'admin') do |user|
  user.email = 'admin@example.com'
  user.password = 'password1234'
  user.role = 'ADMIN'
  user.confirmed_at = Time.now
end

User.find_or_create_by!(username: 'user') do |user|
  user.email = 'user@example.com'
  user.password = 'password1234'
  user.role = 'USER'
  user.confirmed_at = Time.now
end

# Import Books from CSV
require 'csv'

csv_text = File.read(Rails.root.join('lib', 'seeds', 'books.csv'))
csv = CSV.parse(csv_text, headers: true, encoding: 'utf-8')
if Rails.env.development? || Rails.env.test?
  csv = csv.first(100)
end
csv.each do |row|
  Book.find_or_create_by!(title: row['title']) do |book|
    book.title = row['title']
    book.description = row['description']
    book.author = row['author']
    book.isbn = row['isbn']
    book.publish_date = Date.strptime(row['publishDate'], '%m/%d/%y')
    book.cover_image = row['coverImg']
    book.genres = row['genres']
  end
end
