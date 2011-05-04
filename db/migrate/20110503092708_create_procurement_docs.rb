class CreateProcurementDocs < ActiveRecord::Migration
  def self.up
    create_table :procurement_docs do |t|
      t.string :category
      t.string :source
      t.text :remarks
      t.string :proc_document

      t.timestamps
    end
  end

  def self.down
    drop_table :procurement_docs
  end
end
