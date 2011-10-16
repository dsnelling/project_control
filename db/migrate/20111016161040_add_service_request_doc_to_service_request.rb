class AddServiceRequestDocToServiceRequest < ActiveRecord::Migration
  def self.up
    add_column :service_requests, :service_request_doc, :string
  end

  def self.down
    remove_column :service_requests, :service_request_doc
  end
end
