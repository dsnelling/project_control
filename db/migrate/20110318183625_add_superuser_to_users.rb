class AddSuperuserToUsers < ActiveRecord::Migration
  def self.up
    change_table :users do |t|
	  t.boolean :superuser, :default => false
	end
  end

  def self.down
    remove_column :users, :superuser
  end
end
