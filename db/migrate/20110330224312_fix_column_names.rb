class FixColumnNames < ActiveRecord::Migration
  def self.up
    change_column :req_comments, :comment_by, :string
    rename_column :contracts, :expedit_status, :expedite_status
  end

  def self.down
    change_column :req_comments, :comment_by, :text
	rename_column :contracts, :expedite_status, :expedit_status
  end
end
