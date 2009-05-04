class AddModelIdInTablesOfDevices < ActiveRecord::Migration
  def self.up
    add_column :mother_boards, :model_id, :integer
    add_column :harddisks, :model_id, :integer
    add_column :memories, :model_id, :integer
    add_column :cds, :model_id, :integer
    add_column :dvds, :model_id, :integer
    add_column :printers, :model_id, :integer
    add_column :screens, :model_id, :integer
  end

  def self.down
    remove_column :mother_boards, :model_id
    remove_column :harddisks, :model_id
    remove_column :memories, :model_id
    remove_column :cds, :model_id
    remove_column :dvds, :model_id
    remove_column :printers, :model_id
    remove_column :screens, :model_id
  end
end
