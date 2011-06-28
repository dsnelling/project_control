class CreateVendorDocs < ActiveRecord::Migration
  def self.up
    create_table :vendor_docs do |t|
      t.integer :vdoc_requirement_id
      t.string :doc_number
      t.string :title
      t.string :doc_status
      t.date :date_received
      t.string :document
      t.text :remarks

      t.timestamps
    end
  end

  def self.down
    drop_table :vendor_docs
  end
end
