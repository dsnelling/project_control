class CreateServiceRequests < ActiveRecord::Migration
  def self.up
    create_table :service_requests do |t|
      t.string :project
      t.string :request_ref
      t.string :description
      t.string :disclipline
      t.string :status
      t.decimal :auth_cost
      t.datetime :request_date
      t.datetime :auth_date

      t.timestamps
    end
  end

  def self.down
    drop_table :service_requests
  end
end
