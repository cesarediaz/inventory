class AddFieldComputerIdInMotherboard < ActiveRecord::Migration
  def self.up
    add_column :mother_boards, :computer_id, :integer
  end

  def self.down
    remove_column :mother_boards, :computer_id
  end
end
