class CreateContracts < ActiveRecord::Migration
  def self.up
    create_table :contracts do |t|
      t.integer :requisition_id
      t.string :commodity
      t.string :reference
      t.date :commence_date
      t.string :supplier
      t.decimal :value_orig
      t.decimal :value_current
      t.string :delivery_terms
      t.date :delivery_date_contract
      t.date :delivery_date_forecast
      t.string :expedite_contract
      t.string :expedite_email
      t.string :expedite_phone
      t.date :expedite_last_contact
      t.string :expedit_status
      t.string :update_by

      t.timestamps
    end
  end

  def self.down
    drop_table :contracts
  end
end
