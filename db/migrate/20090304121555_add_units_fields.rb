class AddUnitsFields < ActiveRecord::Migration
  def self.up
    add_column :harddisks, :unit, :string, :default => 'mb'
    add_column :memories, :unit, :string, :default => 'mb'
  end

  def self.down
    remove_column :harddisks, :unit
    remove_column :memories, :unit
  end
end
