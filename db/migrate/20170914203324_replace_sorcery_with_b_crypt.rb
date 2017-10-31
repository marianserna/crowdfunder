class ReplaceSorceryWithBCrypt < ActiveRecord::Migration[5.1]
  def change
    remove_column :users, :crypted_password, :string
    remove_column :users, :remember_me_token, :string
    remove_column :users, :remember_me_token_expires_at, :datetime
    remove_column :users, :salt, :string
    add_column :users, :password_digest, :string
  end
end
