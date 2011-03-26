class CreateRequisitions < ActiveRecord::Migration
  def self.up
    create_table :requisitions do |t|
      t.string :req_num
      t.string :commodity
      t.string :scope
      t.string :status
      t.string :mr_doc
      t.decimal :budget_rmb
      t.date :required_on_site
      t.date :enquiry_issued
      t.date :tbt_issued
      t.date :cbt_issued
      t.string :update_by

      t.timestamps
    end
  end

  def self.down
    drop_table :requisitions
  end
end
