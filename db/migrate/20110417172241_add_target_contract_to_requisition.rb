class AddTargetContractToRequisition < ActiveRecord::Migration
  def self.up
    add_column :requisitions, :required_contract, :date
  end

  def self.down
    remove_column :requisitions, :required_contract
  end
end
