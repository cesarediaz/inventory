class AddDescriptionFieldForComputersTable < ActiveRecord::Migration
  def self.up
    add_column :computers, :description, :text
  end

  def self.down
    remove_column :computers, :description
  end
end
