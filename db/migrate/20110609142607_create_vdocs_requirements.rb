class CreateVdocsRequirements < ActiveRecord::Migration
  def self.up
    create_table :vdocs_requirements do |t|
      t.integer :contract_id
      t.string :code
      t.string :description
      t.string :purpose
      t.date :due_date
      t.text :comment

      t.timestamps
    end
  end

  def self.down
    drop_table :vdocs_requirements
  end
end
