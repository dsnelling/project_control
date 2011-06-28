class CorrectVdocColumnName < ActiveRecord::Migration
  def self.up
    add_column :vendor_docs, :vdocs_requirement_id, :integer
	remove_column :vendor_docs, :vdoc_requirement_id
  end

  def self.down
    add_column :vendor_docs, :vdoc_requirement_id, :integer
	remove_column :vendor_docs, :vdocs_requirement_id

  end
end
