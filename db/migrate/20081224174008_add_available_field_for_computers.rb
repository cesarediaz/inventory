class AddAvailableFieldForComputers < ActiveRecord::Migration
  def self.up
    add_column :computers, :available, :boolean, :default => true
  end

  def self.down
    remove_column :computers, :available
  end
end
