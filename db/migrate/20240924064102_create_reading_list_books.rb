class CreateReadingListBooks < ActiveRecord::Migration[7.2]
  def change
    create_table :reading_list_books do |t|
      t.integer :club_id
      t.integer :book_id
      t.timestamp :added_at
      t.string :status
      t.timestamp :completed_at

      t.timestamps
    end
  end
end
