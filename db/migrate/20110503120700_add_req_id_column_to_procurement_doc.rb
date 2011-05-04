class AddReqIdColumnToProcurementDoc < ActiveRecord::Migration
  def self.up
    add_column :procurement_docs, :requisition_id, :integer
	add_column :procurement_docs, :update_by, :string
  end

  def self.down
    remove_column :procurement_docs, :requisition_id
	remove_column :procurement_docs, :update_by
  end
end
