class CreateClubs < ActiveRecord::Migration[7.2]
  def change
    create_table :clubs do |t|
      t.string :name
      t.text :description
      t.references :current_book, null: false, foreign_key: true
      t.references :created_by, null: false, foreign_key: true

      t.timestamps
    end
  end
end
