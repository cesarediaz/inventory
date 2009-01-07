class AddIsPartOfAWorkstation < ActiveRecord::Migration
  def self.up
    add_column :computers, :is_part_of_a_workstation, :boolean, :default => false
  end

  def self.down
    remove_column :computers, :is_part_of_a_workstation
  end
end
