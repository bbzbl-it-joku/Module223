class Club < ApplicationRecord
  belongs_to :current_book
  belongs_to :created_by
end
