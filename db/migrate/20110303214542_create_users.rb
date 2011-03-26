class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.column :name,            :string
	  t.column :hashed_password, :string
	  t.column :salt,            :string
      t.timestamp
    end
  end

  def self.down
    drop_table :users
  end
end
