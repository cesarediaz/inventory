class AddMemoryIdInComputers < ActiveRecord::Migration
  def self.up
    add_column :memories, :computer_id, :integer
  end

  def self.down
    remove_column :memories, :computer_id
  end
end
