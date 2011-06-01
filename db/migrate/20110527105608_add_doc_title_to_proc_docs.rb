class AddDocTitleToProcDocs < ActiveRecord::Migration
  def self.up
    add_column :procurement_docs, :reference, :string
  end

  def self.down
    remove_column :procurement_docs, :reference
  end
end
