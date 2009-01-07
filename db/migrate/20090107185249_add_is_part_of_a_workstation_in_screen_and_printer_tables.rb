class AddIsPartOfAWorkstationInScreenAndPrinterTables < ActiveRecord::Migration
  def self.up
    add_column :printers, :is_part_of_a_workstation, :boolean, :default => false
    add_column :screens, :is_part_of_a_workstation, :boolean, :default => false
  end

  def self.down
    remove_column :printers, :is_part_of_a_workstation
    remove_column :screens, :is_part_of_a_workstation
  end
end
