class ChangeUserFieldnames < ActiveRecord::Migration
  def self.up
    remove_column :users, :hashed_password
	remove_column :users, :salt
	add_column :users, :password_hash, :string
	add_column :users, :password_salt, :string
  end

  def self.down
    add_column :users, :hashed_password, :string
    add_column :users, :salt, :string
	remove_column :users, :password_hash
	remove_column :users, :password_salt
 
  end
end
