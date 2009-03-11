class AddInventoryRegisterToDevices < ActiveRecord::Migration
  def self.up
    add_column :computers, :inventory_register, :string
    add_column :printers, :inventory_register, :string
    add_column :screens, :inventory_register, :string
    add_column :harddisks, :inventory_register, :string
    add_column :mother_boards, :inventory_register, :string
    add_column :cds, :inventory_register, :string
    add_column :dvds, :inventory_register, :string
    add_column :memories, :inventory_register, :string
  end

  def self.down
    remove_column :computers, :inventory_register
    remove_column :printers, :inventory_register
    remove_column :screens, :inventory_register
    remove_column :harddisks, :inventory_register
    remove_column :mother_boards, :inventory_register
    remove_column :cds, :inventory_register
    remove_column :dvds, :inventory_register
    remove_column :memories, :inventory_register
  end
end
