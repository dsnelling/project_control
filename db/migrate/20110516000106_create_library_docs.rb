class CreateLibraryDocs < ActiveRecord::Migration
  def self.up
    create_table :library_docs do |t|
      t.string :category
      t.string :title
      t.text :remarks
      t.string :document

      t.timestamps
    end
  end

  def self.down
    drop_table :library_docs
  end
end
