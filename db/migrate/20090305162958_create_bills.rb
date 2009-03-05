class CreateBills < ActiveRecord::Migration
  def self.up
    create_table :bills do |t|
      t.string :code
      t.timestamps
    end

    create_table :bills_companies, :id => false do |t|
      t.integer :bill_id
      t.integer :company_id
    end
  end

  def self.down
    drop_table :bills
    drop_table :bills_companies
  end
end
