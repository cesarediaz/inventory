class DeleteFieldMotherBoardIdFromComputer < ActiveRecord::Migration
  def self.up
    remove_column :computers, :mother_board_id
  end

  def self.down
    add_column :computers, :mother_board_id, :integer
  end
end
