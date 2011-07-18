class AddCategoryToServiceRequest < ActiveRecord::Migration
  def self.up
    add_column :service_requests, :category, :string
  end

  def self.down
    remove_column :service_requests, :category
  end
end
