class CreateReadingListBooks < ActiveRecord::Migration[7.2]
  def change
    create_table :reading_list_books do |t|
      t.references :club, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true
      t.string :status
      t.datetime :completed_at

      t.timestamps
    end
  end
end
