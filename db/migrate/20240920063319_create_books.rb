class CreateBooks < ActiveRecord::Migration[7.2]
  def change
    create_table :books do |t|
      t.string :title
      t.text :description
      t.string :author
      t.string :isbn
      t.date :publish_date
      t.text :genres
      t.text :cover_image

      t.timestamps
    end
  end
end
