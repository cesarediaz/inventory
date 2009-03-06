class DropTableBillsCompanies < ActiveRecord::Migration
  def self.up
    drop_table :bills_companies
    add_column :bills, :company_id, :integer
  end

  def self.down
    create_table :bills_companies, :id => false do |t|
      t.integer :bill_id
      t.integer :company_id
    end
    remove_column :bills, :company_id
  end
end
