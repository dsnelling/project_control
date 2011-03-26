class CreateReqComments < ActiveRecord::Migration
  def self.up
    create_table :req_comments do |t|
      t.text :comment
      t.text :comment_by
      t.integer :requisition_id

      t.timestamps
    end
  end

  def self.down
    drop_table :req_comments
  end
end
