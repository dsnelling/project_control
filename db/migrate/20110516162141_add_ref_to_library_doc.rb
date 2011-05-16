class AddRefToLibraryDoc < ActiveRecord::Migration
  def self.up
    add_column :library_docs, :reference, :string
  end

  def self.down
    remove_column :library_docs, :reference
  end
end
