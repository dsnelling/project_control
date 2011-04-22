class CreateSiteHours < ActiveRecord::Migration
  def self.up
    create_table :site_hours do |t|
      t.string :project
      t.date :week_start
      t.string :category
      t.integer :owner_hr
      t.integer :epc_hr
      t.integer :svision_hr
      t.integer :constr_hr
      t.integer :total_hr

      t.timestamps
    end
  end

  def self.down
    drop_table :site_hours
  end
end
