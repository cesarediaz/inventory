class AddFieldsOfSizeOfDevices < ActiveRecord::Migration
  def self.up
    add_column :harddisks, :size, :integer, :default => 0
    add_column :memories, :size, :integer, :default => 0
  end

  def self.down
    remove_column :harddisks, :size
    remove_column :memories, :size
  end
end
