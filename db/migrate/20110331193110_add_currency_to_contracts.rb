class AddCurrencyToContracts < ActiveRecord::Migration
  def self.up
    add_column :contracts, :currency, :string
	add_column :requisitions, :bid_applic_approved, :date
  end

  def self.down
    remove_column :contracts, :currency
	remove_column :requisitions, :bid_applic_approved
  end
end
