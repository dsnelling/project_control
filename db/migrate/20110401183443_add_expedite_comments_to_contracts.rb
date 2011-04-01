class AddExpediteCommentsToContracts < ActiveRecord::Migration
  def self.up
    add_column :contracts, :expedite_comment, :text
  end

  def self.down
    remove_column :contracts, :expedite_comment
  end
end
