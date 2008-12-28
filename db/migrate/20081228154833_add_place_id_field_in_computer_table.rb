class AddPlaceIdFieldInComputerTable < ActiveRecord::Migration
  def self.up
    add_column :computers, :place_id, :integer
  end

  def self.down
    remove_column  :computers, :place_id
  end
end
