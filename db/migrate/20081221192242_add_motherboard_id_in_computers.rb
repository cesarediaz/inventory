class AddMotherboardIdInComputers < ActiveRecord::Migration
  def self.up
    add_column :computers, :mother_board_id, :integer
  end

  def self.down
    remove_column :computers, :mother_board_id
  end
end
