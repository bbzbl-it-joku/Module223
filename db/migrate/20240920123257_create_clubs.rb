class CreateClubs < ActiveRecord::Migration[7.2]
  def change
    create_table :clubs do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
      add_column :clubs, :created_by_id, :integer
      add_index :clubs, :created_by_id
      add_foreign_key :clubs, :users, column: :created_by_id
      add_column :clubs, :current_book_id, :integer
      add_index :clubs, :current_book_id
      add_foreign_key :clubs, :books, column: :current_book_id
  end
end
