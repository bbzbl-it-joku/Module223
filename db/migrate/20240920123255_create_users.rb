class CreateUsers < ActiveRecord::Migration[7.2]
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :password_digest
      t.string :role, default: "USER"
      t.string :confirmation_token
      t.datetime :confirmed_at
      t.datetime :confirmation_sent_at
      t.string :unconfirmed_email

      t.timestamps
    end

    add_index :users, :username, unique: true
    add_index :users, :email, unique: true
    add_index :users, :confirmation_token, unique: true
  end
end
