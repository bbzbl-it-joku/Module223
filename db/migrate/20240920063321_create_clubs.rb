class CreateClubs < ActiveRecord::Migration[7.2]
  def change
    create_table :clubs do |t|
      t.string :name
      t.text :description
      t.references :current_book, foreign_key: { to_table: :books }
      t.references :created_by, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
