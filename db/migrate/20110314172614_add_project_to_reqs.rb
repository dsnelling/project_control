class AddProjectToReqs < ActiveRecord::Migration
  def self.up
    change_table :requisitions do |t|
	  t.string :project
	end
  end

  def self.down
    remove_column :project
  end
end
