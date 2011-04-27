class CreateIncidents < ActiveRecord::Migration
  def self.up
    create_table :incidents do |t|
      t.string :project
      t.string :reference
      t.string :category
      t.date :incident_date
      t.string :title
      t.text :description
      t.string :company
      t.string :incident_report

      t.timestamps
    end
  end

  def self.down
    drop_table :incidents
  end
end
