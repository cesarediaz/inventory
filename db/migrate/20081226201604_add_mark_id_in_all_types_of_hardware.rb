class AddMarkIdInAllTypesOfHardware < ActiveRecord::Migration
  def self.up
    add_column :harddisks, :mark_id, :integer
    add_column :mother_boards, :mark_id, :integer
    add_column :cds, :mark_id, :integer
    add_column :dvds, :mark_id, :integer
    add_column :memories, :mark_id, :integer
  end

  def self.down
    remove_column :harddisks, :mark_id
    remove_column :mother_boards, :mark_id
    remove_column :cds, :mark_id
    remove_column :dvds, :mark_id
    remove_column :memories, :mark_id
  end
end
