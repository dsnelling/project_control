class AddUserFieldnames < ActiveRecord::Migration
  def self.up
    change_table :users do |u|
	  u.string :forename
      u.string :surname
      u.string :email_addr
	  u.string :company
      u.boolean :disabled, :default => false 
    end

  end

  def self.down
    remove_column :users, :forename
    remove_column :users, :surname
    remove_column :users, :email_addr
    remove_column :users, :company
    remove_column :users, :disabled
  end
end
