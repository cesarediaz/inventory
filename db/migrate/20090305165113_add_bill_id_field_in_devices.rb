class AddBillIdFieldInDevices < ActiveRecord::Migration
  def self.up
    add_column :computers, :bill_id, :integer, :default => nil
    add_column :screens, :bill_id, :integer, :default => nil
    add_column :printers, :bill_id, :integer, :default => nil
    add_column :dvds, :bill_id, :integer, :default => nil
    add_column :cds, :bill_id, :integer, :default => nil
    add_column :mother_boards, :bill_id, :integer, :default => nil
    add_column :harddisks, :bill_id, :integer, :default => nil
    add_column :memories, :bill_id, :integer, :default => nil
  end

  def self.down
    remove_column :computers, :bill_id
    remove_column :screens, :bill_id
    remove_column :printers, :bill_id
    remove_column :dvds, :bill_id
    remove_column :cds, :bill_id
    remove_column :mother_boards, :bill_id
    remove_column :harddisks, :bill_id
    remove_column :memories, :bill_id
  end
end
