class CreateServiceReports < ActiveRecord::Migration
  def self.up
    create_table :service_reports do |t|
      t.integer :service_request_id
      t.string :report_ref
      t.string :description
      t.integer :actual_cost
      t.string :status
      t.string :document
      t.date :report_date

      t.timestamps
    end
  end

  def self.down
    drop_table :service_reports
  end
end
